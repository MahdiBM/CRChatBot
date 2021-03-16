@testable import App
import Vapor
import SwiftProtobuf

/// Retrieves the Global Leaderboard and return a trophy from one of the players.
func singleTrophyNumberFromGlobalLeaderboard(app: Application) -> Int {
    typealias Leaderboard = DTOs.Protobuf.ScheduleLeaderboard
    let clientRequest = CRAPIRequest.locationsTopPlayersGlobal.clientRequest
    let clientResponse = app.client.send(clientRequest)
    let content = clientResponse.flatMapThrowing {
        response -> [Leaderboard.Item] in
        let data = response.body.contentData()
        let decoded = try Leaderboard(jsonUTF8Data: data, options: .ignoringUnknownFields)
        return decoded.items
    }
    let trophyNumber = content.map { items -> Int in
        guard items.count >= 1000 else {
            fatalError("Global Leaderboard doesn't have 1000 players?!?!"
                        + " Might be a network error from me,"
                        + " or the Clash Royale API test token is not set to work with the current"
                        + " IP address, or Clash Royale servers might be in maintenance break.")
        }
        return Int(items.map(\.trophies)[570])
    }
    
    return try! trophyNumber.wait()
}

