import Vapor
import Fluent

class StreamerRoutes: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let baseRoute = routes.grouped("streamers")
        let adminRoute = baseRoute.grouped(Authenticators.AdminAuthenticator())
        
        adminRoute.get(":name", "add", use: addStreamer)
        adminRoute.get(":name", use: streamerInfo)
        adminRoute.get(":name", "delete", use: streamerDelete)
        adminRoute.get(":name", "requests", use: streamerGetRequests)
        adminRoute.get(":name", "toggleBlacklist", use: streamerToggleBlacklist)
        adminRoute.get(":name", "toggleOnlineChecks", use: streamerToggleOnlineChecks)
        adminRoute.get(":name", "setInfo", use: setStreamerInfo)
        adminRoute.get(":name", "deleteInfo", use: deleteStreamerInfo)
    }
    
    private func addStreamer(_ req: Request) throws -> EventLoopFuture<Streamers> {
        let streamerName = try req.parameters.require("name")
        
        return Streamers.query(on: req.db)
            .filter(\.$channelName, .equal, streamerName)
            .first()
            .flatMapThrowing { streamer -> Void in
                if streamer != nil {
                    throw Failure.notUnique
                }
            }
            .flatMap {
                let streamer = Streamers(id: .init(), channelName: streamerName.lowercased())
                return streamer.save(on: req.db).transform(to: streamer)
            }
    }
    
    private func streamerInfo(_ req: Request) throws -> EventLoopFuture<Streamers> {
        let streamerName = try req.parameters.require("name")
        
        return getStreamer(req, name: streamerName)
    }
    
    private func streamerDelete(_ req: Request)throws -> EventLoopFuture<HTTPStatus> {
        let streamerName = try req.parameters.require("name")
        
        return getStreamer(req, name: streamerName)
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
    private func streamerGetRequests(_ req: Request)
    throws -> EventLoopFuture<Page<UserRequests.Public>> {
        
        struct Params: Content {
            let description: String?
            let addingTimeInterval: Int?
        }
        
        let streamerName = try req.parameters.require("name")
        let params = try req.query.decode(Params.self)
        
        let streamer = getStreamer(req, name: streamerName)
        let streamerId = streamer
            .flatMapThrowing { streamer -> UUID in
                let id = try streamer.requireID()
                return id
            }
        let paginatedUserRequests = streamerId
            .flatMap { id in
                UserRequests.query(on: req.db)
                    .filter(\.$streamer.$id, .equal, id)
                    .sort(\.$timestamp, .descending)
                    .field(\.$username)
                    .field(\.$description)
                    .field(\.$timestamp)
                    .group(.and) { builder in
                        if let description = params.description {
                            builder.filter(\.$description, .equal, description)
                        }
                    }
                    .paginate(for: req)
            }
        let publicUserRequests = paginatedUserRequests
            .map { page -> Page<UserRequests.Public> in
                let newItems: [UserRequests.Public] = page.items.map {
                    $0.convertToPublic(addingTimeInterval: params.addingTimeInterval ?? 0)
                }
                let newPage = Page<UserRequests.Public>
                    .init(items: newItems, metadata: page.metadata)
                return newPage
            }
        
        return publicUserRequests
    }
    
    private func streamerToggleBlacklist(_ req: Request) throws -> EventLoopFuture<Streamers> {
        let streamerName = try req.parameters.require("name")
        
        return getStreamer(req, name: streamerName)
            .flatMap { streamer in
                streamer.isBlacklisted.toggle()
                return streamer.save(on: req.db).transform(to: streamer)
            }
    }
    
    private func streamerToggleOnlineChecks(_ req: Request) throws -> EventLoopFuture<Streamers> {
        let streamerName = try req.parameters.require("name")
        
        return getStreamer(req, name: streamerName)
            .flatMap { streamer in
                streamer.performOnlineChecks.toggle()
                return streamer.save(on: req.db).transform(to: streamer)
            }
    }
    
    private func setStreamerInfo(_ req: Request) throws -> ELF<Streamers> {
        let streamerName = try req.parameters.require("name")
        let keyValue = try req.query.decode(KeyValue.self)
        
        return getStreamer(req, name: streamerName)
            .flatMap { streamer -> ELF<Streamers> in
                streamer.infoDict[keyValue.key] = keyValue.value
                return streamer.save(on: req.db).transform(to: streamer)
            }
    }
    
    private func deleteStreamerInfo(_ req: Request) throws -> ELF<Streamers> {
        let streamerName = try req.parameters.require("name")
        let keyValue = try req.query.decode(KeyValue.self)
        
        return getStreamer(req, name: streamerName)
            .flatMap { streamer -> ELF<Streamers> in
                streamer.infoDict[keyValue.key] = nil
                return streamer.save(on: req.db).transform(to: streamer)
            }
    }
    
    private func getStreamer(_ req: Request, name: String) -> ELF<Streamers> {
        Streamers.query(on: req.db)
            .filter(\.$channelName, .equal, name)
            .first()
            .unwrap(or: Abort(HTTPStatus.badRequest))
    }
    
    
}
