@testable import App
import XCTVapor

final class CRAPIControllerTests: XCTestCase {
    var app: Application!
    let adminAuthenticator = Authenticators.AdminAuthenticator()
    let baseUrl = "twitch/api/v1/crapi/"
    
    override func setUpWithError() throws {
        app = Application(.testing)
        try Configuration(app).perform()
    }
    
    override func tearDown() {
        app.shutdown()
    }
    
    func testCRAAPIRoutes() throws {
        let crapiCases = CRAPIRequest.allCases
        for crapiCase in crapiCases {
            try app.test(.GET, baseUrl + crapiCase.testUrlSuffix, beforeRequest: { req in
                req.headers.basicAuthorization = adminAuthenticator.ultimateOwnerAdmin
            }, afterResponse: { res in
                if res.status == .serviceUnavailable {
                    fatalError("Servers seem to be in maintenance break."
                                + " Try running tests in 30/60/90 mins.")
                }
                if res.status == .forbidden {
                    fatalError("Most likely the test token and your IP address don't match")
                }
                switch crapiCase {
                case .tournamentsSearch, .locationsGlobalTourneyRankings:
                    XCTAssertTrue(res.status == .ok || res.status == .notFound)
                default:
                    XCTAssertEqual(res.status, .ok)
                }
            })
        }
    }
    
}


//MARK: - testUrlSuffix
private extension CRAPIRequest {
    var testUrlSuffix: String {
        let requestCase: CRAPIRequest
        switch self {
        case .cards:
            requestCase = .cards
        case .globalTournaments:
            requestCase = .globalTournaments
        case .clansSearch:
            requestCase = .clansSearch(name: "Hello")
        case .clanSearch:
            requestCase = .clanSearch(tag: "9PJ82CRC")
        case .clansMembers:
            requestCase = .clansMembers(tag: "9PJ82CRC")
        case .clansCurrentRiverRace:
            requestCase = .clansCurrentRiverRace(tag: "9PJ82CRC")
        case .clansRiverRaceLog:
            requestCase = .clansRiverRaceLog(tag: "9PJ82CRC")
        case .playersSearch:
            requestCase = .playersSearch(tag: "VPU8G")
        case .playersBattleLog:
            requestCase = .playersBattleLog(tag: "VPU8G")
        case .playersChests:
            requestCase = .playersChests(tag: "VPU8G")
        case .locationsList:
            requestCase = .locationsList
        case .locationsLocationInfo:
            requestCase = .locationsLocationInfo(location: .AF)
        case .locationsTopClans:
            requestCase = .locationsTopClans(location: .AF)
        case .locationsTopPlayers:
            requestCase = .locationsTopPlayers(location: .AF)
        case .locationsTopWarClans:
            requestCase = .locationsTopWarClans(location: .AF)
        case .locationsTopClansGlobal:
            requestCase = .locationsTopClansGlobal
        case .locationsTopPlayersGlobal:
            requestCase = .locationsTopPlayersGlobal
        case .locationsTopWarClansGlobal:
            requestCase = .locationsTopWarClansGlobal
        case .locationsGlobalTourneyRankings:
            requestCase = .locationsGlobalTourneyRankings(tag: "G8VUPG")
        case .tournamentsNameSearch:
            requestCase = .tournamentsNameSearch(name: "Hello")
        case .tournamentsSearch:
            requestCase = .tournamentsSearch(tag: "G8VUPG")
        }
        return requestCase.urlSuffix
    }
}
