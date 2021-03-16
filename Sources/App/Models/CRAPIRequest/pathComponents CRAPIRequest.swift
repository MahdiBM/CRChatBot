import Vapor

extension CRAPIRequest {
    /// Path components that correspond to self.
    var pathComponents: [PathComponent] {
        switch self {
        case .cards:
            return ["cards"]
        case .globalTournaments:
            return ["globaltournaments"]
        case .clansSearch:
            return ["clans"]
        case .clanSearch:
            return ["clans", ":tag"]
        case .clansMembers:
            return ["clans", ":tag", "members"]
        case .clansCurrentRiverRace:
            return ["clans", ":tag", "currentriverrace"]
        case .clansRiverRaceLog:
            return ["clans", ":tag", "riverracelog"]
        case .playersSearch:
            return ["players", ":tag"]
        case .playersBattleLog:
            return ["players", ":tag", "battlelog"]
        case .playersChests:
            return ["players", ":tag", "upcomingchests"]
        case .locationsList:
            return ["locations"]
        case .locationsLocationInfo:
            return ["locations", ":id"]
        case .locationsTopClans:
            return ["locations", ":id", "rankings", "clans"]
        case .locationsTopPlayers:
            return ["locations", ":id", "rankings", "players"]
        case .locationsTopWarClans:
            return ["locations", ":id", "rankings", "clanwars"]
        case .locationsTopClansGlobal:
            return ["locations", "global", "rankings", "clans"]
        case .locationsTopPlayersGlobal:
            return ["locations", "global", "rankings", "players"]
        case .locationsTopWarClansGlobal:
            return ["locations", "global", "rankings", "clanwars"]
        case .locationsGlobalTourneyRankings:
            return ["locations", "global", "rankings", "tournaments", ":tag"]
        case .tournamentsNameSearch:
            return ["tournaments"]
        case .tournamentsSearch:
            return ["tournaments", ":tag"]
        }
    }
}
