import Foundation

extension CRAPIRequest {
    /// Refines tag to make sure it is ready to be passed in url
    /// - Parameter tag: the tag
    /// - Returns: refined value of the entered tag
    private func refine(_ tag: String) -> String {
        var tag = tag
        tag.removeAll { $0 == "#" }
        return "%23" + tag.uppercased()
    }
    
    /// CRAPI url prefix, to be appended at the end of `Self.baseUrl`
    /// so they make a correct url for a request to be made to CRAPI.
    var urlSuffix: String {
        switch self {
        case .cards:
            return "cards"
        case .globalTournaments:
            return "globaltournaments"
        case .clansSearch(let name):
            return "clans?name=\(name)"
        case .clanSearch(let tag):
            return "clans/\(refine(tag))"
        case .clansMembers(let tag):
            return "clans/\(refine(tag))/members"
        case .clansCurrentRiverRace(let tag):
            return "clans/\(refine(tag))/currentriverrace"
        case .clansRiverRaceLog(let tag):
            return "clans/\(refine(tag))/riverracelog"
        case .playersSearch(let tag):
            return "players/\(refine(tag))"
        case .playersBattleLog(let tag):
            return "players/\(refine(tag))/battlelog"
        case .playersChests(let tag):
            return "players/\(refine(tag))/upcomingchests"
        case .locationsList:
            return "locations"
        case .locationsLocationInfo(let location):
            return "locations/\(location.value.id)"
        case .locationsTopClans(let location):
            return "locations/\(location.value.id)/rankings/clans"
        case .locationsTopPlayers(let location):
            return "locations/\(location.value.id)/rankings/players"
        case .locationsTopWarClans(let location):
            return "locations/\(location.value.id)/rankings/clanwars"
        case .locationsTopClansGlobal:
            return "locations/global/rankings/clans"
        case .locationsTopPlayersGlobal:
            return "locations/global/rankings/players"
        case .locationsTopWarClansGlobal:
            return "locations/global/rankings/clanwars"
        case .locationsGlobalTourneyRankings(let tag):
            return "locations/global/rankings/tournaments/\(refine(tag))"
        case .tournamentsNameSearch(let name):
            return "tournaments?name=\(name)"
        case .tournamentsSearch(let tag):
            return "tournaments/\(refine(tag))"
        }
    }
}
