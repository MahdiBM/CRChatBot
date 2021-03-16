import Foundation

extension CRAPIRequest: CaseIterable {
    static var allCases: [CRAPIRequest] {
        [.cards,
         .globalTournaments,
         .clansSearch(name: ""),
         .clanSearch(tag: ""),
         .clansMembers(tag: ""),
         .clansCurrentRiverRace(tag: ""),
         .clansRiverRaceLog(tag: ""),
         .playersSearch(tag: ""),
         .playersBattleLog(tag: ""),
         .playersChests(tag: ""),
         .locationsList,
         .locationsLocationInfo(location: .AC),
         .locationsTopClans(location: .AC),
         .locationsTopPlayers(location: .AC),
         .locationsTopWarClans(location: .AC),
         .locationsTopClansGlobal,
         .locationsTopPlayersGlobal,
         .locationsTopWarClansGlobal,
         .locationsGlobalTourneyRankings(tag: ""),
         .tournamentsNameSearch(name: ""),
         .tournamentsSearch(tag: "")]
    }
}
