import Vapor

// CRAPI = Clash Royale API

/// A type to help make requests to the Official Clash Royale API.
enum CRAPIRequest {
    static let baseUrl = "https://api.clashroyale.com/v1/"
    
    case cards
    case globalTournaments
    case clansSearch(name: String)
    case clanSearch(tag: String)
    case clansMembers(tag: String)
    case clansCurrentRiverRace(tag: String)
    case clansRiverRaceLog(tag: String)
    case playersSearch(tag: String)
    case playersBattleLog(tag: String)
    case playersChests(tag: String)
    case locationsList
    case locationsLocationInfo(location: DataSet.Regions)
    case locationsTopClans(location: DataSet.Regions)
    case locationsTopPlayers(location: DataSet.Regions)
    case locationsTopWarClans(location: DataSet.Regions)
    case locationsTopClansGlobal
    case locationsTopPlayersGlobal
    case locationsTopWarClansGlobal
    case locationsGlobalTourneyRankings(tag: String)
    case tournamentsNameSearch(name: String)
    case tournamentsSearch(tag: String)
}
