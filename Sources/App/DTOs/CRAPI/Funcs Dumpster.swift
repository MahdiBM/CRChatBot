import Vapor

/*
 I just copy-pasted these functions from one of my other projects,
 thats why they are not as polished.
 */

extension DTOs.CRAPI {
    struct Funcs { }
}

private typealias Funcs = DTOs.CRAPI.Funcs
private typealias Card = Funcs.Card
private typealias Player = Funcs.Player
private typealias Clan = Funcs.Clan
private typealias Battle = Funcs.Battle

extension Funcs {
    class Card { }
}

extension Funcs {
    class Player { }
}

extension Funcs {
    class Clan { }
}

extension Funcs {
    class Battle { }
}

extension Player {
    static func linkStringForOpenningInGame(tag: String) -> String {
        let tag = tag.uppercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "#", with: "")
            
        return "clashroyale://playerInfo?id=\(tag)"
    }
}

extension Clan {
    static func linkStringForOpenningInGame(tag: String) -> String {
        let tag = tag.uppercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "#", with: "")
            
        return "clashroyale://clanInfo?id=\(tag)"
    }
}


extension Battle {
    static func title(battleName: String, challengeTitle: String, isLadderTournament: Bool) -> String {
        
        if challengeTitle == "Grand Challenge" { return "Grand Challenge" }
        else if challengeTitle == "Classic Challenge" { return "Classic Challenge" }
        else if isLadderTournament { return "Global Tournament" }
        else if battleName == "ClanWar_BoatBattle" { return "Clan War Boat Battle" }
        else if battleName == "CW_Battle_1v1" { return "Clan War 1v1" }
        else if battleName == "CW_Duel_1v1" { return "Clan War Duel" }
        else {
            var battleTitle = battleName
                .replacingOccurrences(of: "_", with: "")
                .replacingOccurrences(of: "Competitive", with: "Challenge")
                .replacingOccurrences(of: "DoubleDeck", with: "MegaDeck")
                .replacingOccurrences(of: "Overtime", with: "SuddenDeath")
                .replacingOccurrences(of: "Spawn", with: "")
                .replacingOccurrences(of: "Friendly", with: "FriendlyBattle")
            
            if challengeTitle != "" {
                battleTitle = battleTitle.replacingOccurrences(of: "Tournament", with: "Challenge")
            }
            
            let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "2016", "2017", "2018", "2019", "2020", "2021", "2022", " A", " B", " C", " D", " E", " F", " G", " H", " I", " J", " K", " L", " M", " N", " O", " P", " Q", " R", " S", " T", " U", " V", " W", " X", " Y", " Z", " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 ", " 2016 ", " 2017 ", " 2018 ", " 2019 ", " 2020 ", " 2021 ", " 2022 "]
            
            for ind in 0...41 {
                battleTitle = battleTitle.replacingOccurrences(of: letters[ind], with: letters[ind+42])
            }
            
            battleTitle = battleTitle.replacingOccurrences(of: "Team Vs Team", with: " 2v2")
            
            if battleTitle.firstTrailingIndex(of: "Modern") == nil {
                battleTitle = battleTitle.replacingOccurrences(of: "Mode", with: "")
            }
            
            if (battleTitle.map {$0})[0] == " " {
                battleTitle = battleTitle.remove(at: 0)
            }
            
            battleTitle = battleTitle.replacingOccurrences(of: "  ", with: " ")
            
            return battleTitle
        }
    }
}

extension Battle {
    static func titleImageName(battle: DTOs.CRAPI.PlayerBattle) -> String {
        
        let battleTitle = battle.title
        let challengeTitle = battle.challengeTitle
        let isLadderTournament = battle.isLadderTournament
        let teamSize = battle.team.count
        
        let b = battleTitle.contains("Retro")
        let c = battleTitle.contains("Modern")
        let d = battleTitle.contains("Draft")
        let e = battleTitle.contains("Ghost")
        let f = battleTitle.contains("Lumberjack")
        let g = battleTitle.contains("Fisherman")
        let h = battleTitle.contains("WallBreakers")
        let i = battleTitle.contains("Dragon")
        //    let j = alpha.contains("Global")
        let k = battleTitle.contains("Tournament")
        let l = battleTitle.contains("Ladder")
        let m = battleTitle.contains("Touchdown")
        let n = battleTitle.contains("DoubleDeck") // Mega Deck
        let o = battleTitle.contains("Friendly")
        let p = battleTitle.contains("Decks")
        let q = battleTitle.contains("Guards")
        let r = battleTitle.contains("Heist")
        let s = battleTitle.contains("DoubleElixir")
        let t = battleTitle.contains("TripleElixir")
        let u = battleTitle.contains("RampUp")
        let v = battleTitle.contains("SuddenDeath")
        let w = battleTitle.contains("Rage")
        let x = battleTitle.contains("Capture")
        
        if isLadderTournament { return "global-tournament" }
        else if teamSize == 2 { return "2v2" }
        else if battleTitle == "Clan War Boat Battle" { return "boat-battle" }
        else if battleTitle == "Clan War 1v1" { return "war-pvp" }
        else if battleTitle == "Clan War Duel" { return "duel" }
        else if o { return "friendly" }
        else if n { return "mega-deck" }
        else if d { return "draft" }
        else if m { return "touchdown" }
        else if w { return "rage-ladder" }
        else if r { return "heist" }
        else if p { return "classic-decks" }
        else if e { return "royal-ghost" }
        else if f { return "lumberjack" }
        else if g { return "fisherman" }
        else if h { return "wall-breakers" }
        else if q { return "guards" }
        else if i { return "dragon-hunt" }
        else if x { return "elixir-capture" }
        else if v { return "sudden-death" }
        else if s { return "double-elixir" }
        else if t { return "triple-elixir" }
        else if u { return "rampup" }
        else if k { return "tournament" }
        else if challengeTitle == "Classic Challenge" { return "challenge-classic" }
        else if challengeTitle == "Grand Challenge" { return "challenge-grand" }
        else if l { return "battle" }
        else if b { return "retro-royale" }
        else if c { return "classic-decks" }
        else { return "battle-unknown" }
        
    }
}

extension Clan {
    static func badgeName(badgeId: Int) -> String {
        return DataSet.ClanBadge.all.first{$0.id == badgeId}?.name ?? DataSet.ClanBadge.noClan.name
    }
}

extension Clan {
    static func clanType(type: String) -> String {
        switch type {
        case "inviteOnly": return "Invite only"
        case "open": return "Open"
        default: return "Closed"
        }
    }
}

extension Card {
    static func level(oldLevel: Int, maxLevel: Int) -> Int {
        return (13 - (maxLevel - oldLevel))
    }
}

extension Card {
    static func isMaxed(oldLevel: Int, maxLevel: Int) -> Bool {
        return oldLevel == maxLevel
    }
}

extension Card {
    static func isReadyToUpgrade(count: Int,
                                 upgradeIsPossibleAtThisCardCount: Int) -> Bool {
        
        return count > upgradeIsPossibleAtThisCardCount
    }
}

extension Card {
    static func upgradeIsPossibleAtThisCardCount(rarity: DataSet.CardRarity, oldLevel: Int) -> Int {
        let common = [1,2,4,10,20,50,100,200,400,800,1000,2000,5000,10000]
        let rare = [1,2,4,10,20,50,100,200,400,800,1000,2000]
        let epic = [1,2,4,10,20,50,100,200,400]
        let legendary = [1,2,4,10,20,50]

        switch rarity {
        case .common: return common[oldLevel]
        case .rare: return rare[oldLevel]
        case .epic: return epic[oldLevel]
        case .legendary: return legendary[oldLevel]
        }
    }
}

extension Card {
    static func upgradeableToLevel(rarity: DataSet.CardRarity, count: Int, level: Int) -> Int {

        var count = count
        var inti = level

        let common = [1,2,4,10,20,50,100,200,400,800,1000,2000,5000,10000]
        let rare = [1,2,4,10,20,50,100,200,400,800,1000,2000]
        let epic = [1,2,4,10,20,50,100,200,400]
        let legendary = [1,2,4,10,20,50]

        switch rarity {
        case .common:
            while count >= common[inti] {
                count -= common[inti]
                inti += 1
            }
        case .rare:
            while count >= rare[inti-2] {
                count -= rare[inti-2]
                inti += 1
            }
        case .epic:
            while count >= epic[inti-5] {
                count -= epic[inti-5]
                inti += 1
            }
        case .legendary:
            while count >= legendary[inti-8] {
                count -= legendary[inti-8]
                inti += 1
            }
        }

        return inti
    }
}

extension Card {
    static func currentCountPlusUsedCount(count: Int, level: Int, rarity: DataSet.CardRarity) -> Int {
        var cardCount = count

        switch rarity {
        case .common:
            switch level {
            case 2: cardCount += 2
            case 3: cardCount += 6
            case 4: cardCount += 16
            case 5: cardCount += 36
            case 6: cardCount += 86
            case 7: cardCount += 186
            case 8: cardCount += 386
            case 9: cardCount += 786
            case 10: cardCount += 1586
            case 11: cardCount += 2586
            case 12: cardCount += 4586
            case 13: cardCount += 9586
            default: {}()
            }
        case .rare:
            switch level {
            case 4: cardCount += 2
            case 5: cardCount += 6
            case 6: cardCount += 16
            case 7: cardCount += 36
            case 8: cardCount += 86
            case 9: cardCount += 186
            case 10: cardCount += 386
            case 11: cardCount += 786
            case 12: cardCount += 1586
            case 13: cardCount += 2586
            default: {}()
            }
        case .epic:
            switch level {
            case 7: cardCount += 2
            case 8: cardCount += 6
            case 9: cardCount += 16
            case 10: cardCount += 36
            case 11: cardCount += 86
            case 12: cardCount += 186
            case 13: cardCount += 386
            default: {}()
            }
        case .legendary:
            switch level {
            case 10: cardCount += 2
            case 11: cardCount += 6
            case 12: cardCount += 16
            case 13: cardCount += 36
            default: {}()
            }
        }

        return cardCount
    }
}

extension Card {
    static func progressText(count: Int, level: Int, rarity: DataSet.CardRarity) -> String {

        let allCardCountUpToNow = currentCountPlusUsedCount(count: count, level: level, rarity: rarity)
        let upgradePercentageInt = (allCardCountUpToNow*100)/rarity.cardCountNeededToMaxOne

        return "\(upgradePercentageInt)%"
    }
}
