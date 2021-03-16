import Foundation

extension DataSet {
    enum Chests {
        case grandChallenge(wins: Int)
        case classicChallenge(wins: Int)
        case wooden(arena: DataSet.Arena)
        case silver(arena: DataSet.Arena)
        case golden(arena: DataSet.Arena)
        case crown(arena: DataSet.Arena)
        case magical(arena: DataSet.Arena)
        case giant(arena: DataSet.Arena)
        case megaLightning(arena: DataSet.Arena)
        case lightning(arena: DataSet.Arena)
        case kings(arena: DataSet.Arena)
        case epic(arena: DataSet.Arena)
        case legendary
    }
}

extension DataSet.Chests {
    var contents: Contents {
        typealias T = Contents
        
        switch self {
        case .grandChallenge(let wins):
            switch wins {
            case 0: return T.challengeChest(20,20,20,0,1400)
            case 1: return T.challengeChest(30,30,30,0,1900)
            case 2: return T.challengeChest(50,50,50,0,2500)
            case 3: return T.challengeChest(85,85,85,0,3200)
            case 4: return T.challengeChest(135,135,135,0,4000)
            case 5: return T.challengeChest(185,185,185,0,5000)
            case 6: return T.challengeChest(250,250,250,0,6200)
            case 7: return T.challengeChest(330,330,330,0,7600)
            case 8: return T.challengeChest(420,420,420,0,9300)
            case 9: return T.challengeChest(530,530,530,0,11500)
            case 10: return T.challengeChest(670,670,670,0,14200)
            case 11: return T.challengeChest(860,860,860,0,17500)
            default: return T.challengeChest(1100,1100,1100,0,22000)
            }
        case .classicChallenge(let wins):
            switch wins {
            case 0: return T.challengeChest(2,2,2,0,130)
            case 1: return T.challengeChest(3,3,3,0,180)
            case 2: return T.challengeChest(5,5,5,0,240)
            case 3: return T.challengeChest(8,8,8,0,310)
            case 4: return T.challengeChest(12,12,12,0,390)
            case 5: return T.challengeChest(17,17,17,0,480)
            case 6: return T.challengeChest(23,23,23,0,590)
            case 7: return T.challengeChest(30,30,30,0,720)
            case 8: return T.challengeChest(38,38,38,0,880)
            case 9: return T.challengeChest(48,48,48,0,1080)
            case 10: return T.challengeChest(61,61,61,0,1330)
            case 11: return T.challengeChest(78,78,78,0,1630)
            default: return T.challengeChest(100,100,100,0,2000)
            }
        case .wooden(let arena):
            switch arena {
            case .arena1: return T(.wooden(arena: .arena1),3,0,0,0,21,24)
            case .arena2: return T(.wooden(arena: .arena1),4,0,0,0,30)
            case .arena3: return T(.wooden(arena: .arena1),5,0,0,0,35,40)
            case .arena4: return T(.wooden(arena: .arena1),6,0,0,0,42,48)
            case .arena5: return T(.wooden(arena: .arena1),7,0,0,0,49,56)
            case .arena6: return T(.wooden(arena: .arena1),8,0,0,0,56,64)
            case .arena7: return T(.wooden(arena: .arena1),9,0,0,0,63,72)
            case .arena8: return T(.wooden(arena: .arena1),9,1,0,0,70,80)
            case .arena9: return T(.wooden(arena: .arena1),10,1,0,0,77,88)
            case .arena10: return T(.wooden(arena: .arena1),11,1,0,0,84,96)
            case .arena11: return T(.wooden(arena: .arena1),12,1,0,0,91,104)
            case .arena12: return T(.wooden(arena: .arena1),13,1,0,0,98,112)
            default: return T(.wooden(arena: .arena1),14,1,0,0,105,120)
            }
        case .silver(let arena):
            switch arena {
            case .arena1: return T(.silver(arena: .arena1),4,0,0,0,28,32)
            case .arena2: return T(.silver(arena: .arena1),5,0,0,0,37.5)
            case .arena3: return T(.silver(arena: .arena1),7,0,0,0,49,56)
            case .arena4: return T(.silver(arena: .arena1),8,0,0,0,56,64)
            case .arena5: return T(.silver(arena: .arena1),8,1,0,0,63,72)
            case .arena6: return T(.silver(arena: .arena1),9,1,0,0,70,80)
            case .arena7: return T(.silver(arena: .arena1),11,1,0,0,84,96)
            case .arena8: return T(.silver(arena: .arena1),12,1,0,0,91,104)
            case .arena9: return T(.silver(arena: .arena1),13,1,0,0,98,112)
            case .arena10: return T(.silver(arena: .arena1),14,1,0,0,105,120)
            case .arena11: return T(.silver(arena: .arena1),15,1,0,0,112,128)
            case .arena12: return T(.silver(arena: .arena1),16,2,0,0,126,144)
            default: return T(.silver(arena: .arena1),17,2,0,0,133,152)
            }
        case .golden(let arena):
            switch arena {
            case .arena1: return T(.golden(arena: .arena1),6,2,0,0,112,128)
            case .arena2: return T(.golden(arena: .arena1),9,2,0,0,165)
            case .arena3: return T(.golden(arena: .arena1),11,3,0,0,196,224)
            case .arena4: return T(.golden(arena: .arena1),12,4,0,0,224,256)
            case .arena5: return T(.golden(arena: .arena1),14,4,0,0,252,288)
            case .arena6: return T(.golden(arena: .arena1),16,5,0,0,294,336)
            case .arena7: return T(.golden(arena: .arena1),18,5,0,0,322,368)
            case .arena8: return T(.golden(arena: .arena1),20,6,0,0,364,416)
            case .arena9: return T(.golden(arena: .arena1),21,7,0,0,392,448)
            case .arena10: return T(.golden(arena: .arena1),23,7,0,0,420,480)
            case .arena11: return T(.golden(arena: .arena1),25,8,0,0,462,528)
            case .arena12: return T(.golden(arena: .arena1),27,8,0,0,490,560)
            default: return T(.golden(arena: .arena1),29,9,0,0,532,608)
            }
        case .crown(let arena):
            switch arena {
            case .arena1: return T(.crown(arena: .arena1),14,2,0,0,224,256,strikes:6)
            case .arena2: return T(.crown(arena: .arena1),19,3,0,0,308,352,strikes:6)
            case .arena3: return T(.crown(arena: .arena1),23,4,0,0,378,432,strikes:6)
            case .arena4: return T(.crown(arena: .arena1),27,5,0,0,448,512,strikes:6)
            case .arena5: return T(.crown(arena: .arena1),31,6,0,0,518,592,strikes:6)
            case .arena6: return T(.crown(arena: .arena1),35,7,0,0,588,672,strikes:6)
            case .arena7: return T(.crown(arena: .arena1),39,7,0,0,644,736,strikes:6)
            case .arena8: return T(.crown(arena: .arena1),43,8,0,0,714,816,strikes:6)
            case .arena9: return T(.crown(arena: .arena1),47,9,0,0,784,896,strikes:6)
            case .arena10: return T(.crown(arena: .arena1),51,10,0,0,854,976,strikes:6)
            case .arena11: return T(.crown(arena: .arena1),55,11,0,0,924,1056,strikes:6)
            case .arena12: return T(.crown(arena: .arena1),59,11,0,0,980,1120,strikes:6)
            default: return T(.crown(arena: .arena1),63,12,0,0,1050,1200,strikes:6)
            }
        case .magical(let arena):
            switch arena {
            case .arena1: return T(.magical(arena: .arena1),14,4,2,0,320)
            case .arena2: return T(.magical(arena: .arena1),20,5,2,0,432)
            case .arena3: return T(.magical(arena: .arena1),35,6,3,0,544)
            case .arena4: return T(.magical(arena: .arena1),28,8,4,0,640)
            case .arena5: return T(.magical(arena: .arena1),33,9,4,0,736)
            case .arena6: return T(.magical(arena: .arena1),37,10,5,0,832)
            case .arena7: return T(.magical(arena: .arena1),42,11,5,0,928)
            case .arena8: return T(.magical(arena: .arena1),46,12,6,0,1024)
            case .arena9: return T(.magical(arena: .arena1),49,14,7,0,1120)
            case .arena10: return T(.magical(arena: .arena1),54,15,7,0,1216)
            case .arena11: return T(.magical(arena: .arena1),58,16,8,0,1312)
            case .arena12: return T(.magical(arena: .arena1),63,17,8,0,1408)
            default: return T(.magical(arena: .arena1),67,18,9,0,1504)
            }
        case .giant(let arena):
            switch arena {
            case .arena1: return T(.giant(arena: .arena1),56,14,0,0,630)
            case .arena2: return T(.giant(arena: .arena1),76,19,0,0,855)
            case .arena3: return T(.giant(arena: .arena1),96,23,0,0,1071)
            case .arena4: return T(.giant(arena: .arena1),112,28,0,0,1260)
            case .arena5: return T(.giant(arena: .arena1),129,32,0,0,1449)
            case .arena6: return T(.giant(arena: .arena1),146,36,0,0,1638)
            case .arena7: return T(.giant(arena: .arena1),163,40,0,0,1827)
            case .arena8: return T(.giant(arena: .arena1),180,44,0,0,2016)
            case .arena9: return T(.giant(arena: .arena1),196,49,0,0,2205)
            case .arena10: return T(.giant(arena: .arena1),213,53,0,0,2394)
            case .arena11: return T(.giant(arena: .arena1),230,57,0,0,2583)
            case .arena12: return T(.giant(arena: .arena1),247,61,0,0,2772)
            default: return T(.giant(arena: .arena1),264,65,0,0,2961)
            }
        case .megaLightning(let arena):
            switch arena {
            case .arena1: return T(.megaLightning(arena: .arena1),138,36,6,0,1620,strikes:3)
            case .arena2: return T(.megaLightning(arena: .arena1),187,48,8,0,2187,strikes:3)
            case .arena3: return T(.megaLightning(arena: .arena1),235,61,10,0,2754,strikes:4)
            case .arena4: return T(.megaLightning(arena: .arena1),276,72,12,0,3240,strikes:4)
            case .arena5: return T(.megaLightning(arena: .arena1),319,82,13,0,3726,strikes:5)
            case .arena6: return T(.megaLightning(arena: .arena1),360,93,15,0,4212,strikes:5)
            case .arena7: return T(.megaLightning(arena: .arena1),401,104,17,0,4698,strikes:6)
            case .arena8: return T(.megaLightning(arena: .arena1),442,115,19,0,5184,strikes:6)
            case .arena9: return T(.megaLightning(arena: .arena1),483,126,21,0,5670,strikes:7)
            case .arena10: return T(.megaLightning(arena: .arena1),526,136,22,0,6156,strikes:7)
            case .arena11: return T(.megaLightning(arena: .arena1),567,147,24,0,6642,strikes:8)
            case .arena12: return T(.megaLightning(arena: .arena1),607,158,26,1,7128,strikes:8)
            default: return T(.megaLightning(arena: .arena1),648,169,28,1,7614,strikes:8)
            }
        case .lightning(let arena):
            switch arena {
            case .arena1: return T(.lightning(arena: .arena1),67,13,1,0,410,strikes: 2)
            case .arena2: return T(.lightning(arena: .arena1),70,14,1,0,430,strikes: 2)
            case .arena3: return T(.lightning(arena: .arena1),74,14,1,0,450,strikes: 3)
            case .arena4: return T(.lightning(arena: .arena1),77,15,1,0,470,strikes: 3)
            case .arena5: return T(.lightning(arena: .arena1),80,16,1,0,490,strikes: 4)
            case .arena6: return T(.lightning(arena: .arena1),83,16,2,0,510,strikes: 4)
            case .arena7: return T(.lightning(arena: .arena1),86,17,2,0,530,strikes: 4)
            case .arena8: return T(.lightning(arena: .arena1),89,18,1,0,550,strikes: 4)
            case .arena9: return T(.lightning(arena: .arena1),93,18,2,0,570,strikes: 5)
            case .arena10: return T(.lightning(arena: .arena1),96,19,2,0,590,strikes: 5)
            case .arena11: return T(.lightning(arena: .arena1),99,20,2,0,610,strikes: 5)
            case .arena12: return T(.lightning(arena: .arena1),103,20,2,0,630,strikes: 5)
            default: return T(.lightning(arena: .arena1),106,21,2,0,650,strikes: 5)
            }
        case .kings(let arena):
            switch arena {
            case .arena1: return T(.kings(arena: .arena1),176,48,16,0,2900)
            case .arena2: return T(.kings(arena: .arena1),184,50,16,0,3000)
            case .arena3: return T(.kings(arena: .arena1),191,52,17,0,3100)
            case .arena4: return T(.kings(arena: .arena1),198,54,18,0,3200)
            case .arena5: return T(.kings(arena: .arena1),206,56,18,0,3400)
            case .arena6: return T(.kings(arena: .arena1),213,58,19,0,3500)
            case .arena7: return T(.kings(arena: .arena1),219,60,20,0,3600)
            case .arena8: return T(.kings(arena: .arena1),227,62,20,0,3700)
            case .arena9: return T(.kings(arena: .arena1),234,64,21,0,3800)
            case .arena10: return T(.kings(arena: .arena1),241,66,22,0,4000)
            case .arena11: return T(.kings(arena: .arena1),249,68,22,0,4100)
            case .arena12: return T(.kings(arena: .arena1),256,70,23,0,4200)
            default: return T(.kings(arena: .arena1),263,72,24,1,4300)
            }
        case .epic(let arena):
            switch arena {
            case .arena1: return T(.epic(arena: .arena1),0,0,6,0,0)
            case .arena2: return T(.epic(arena: .arena1),0,0,8,0,0)
            case .arena3: return T(.epic(arena: .arena1),0,0,10,0,0)
            case .arena4: return T(.epic(arena: .arena1),0,0,12,0,0)
            case .arena5: return T(.epic(arena: .arena1),0,0,13,0,0)
            case .arena6: return T(.epic(arena: .arena1),0,0,15,0,0)
            case .arena7: return T(.epic(arena: .arena1),0,0,17,0,0)
            case .arena8: return T(.epic(arena: .arena1),0,0,19,0,0)
            case .arena9: return T(.epic(arena: .arena1),0,0,20,0,0)
            case .arena10: return T(.epic(arena: .arena1),0,0,20,0,0)
            case .arena11: return T(.epic(arena: .arena1),0,0,20,0,0)
            case .arena12: return T(.epic(arena: .arena1),0,0,20,0,0)
            default: return T(.epic(arena: .arena1),0,0,20,0,0)
            }
        case .legendary: return T(.legendary,0,0,0,1,0)
        }
    }
}

extension DataSet.Chests {
    var chanceFactor: (rare: Double, epic: Double, legendary: Double) {
        switch self {
        case .grandChallenge: return (rare: 5, epic: 100, legendary: 2000)
        case .classicChallenge: return (rare: 5, epic: 100, legendary: 2000)
        case .wooden: return (rare: 10, epic: 200, legendary: 4000)
        case .silver: return (rare: 10, epic: 200, legendary: 4000)
        case .golden: return (rare: 9, epic: 500, legendary: 10000)
        case .crown: return (rare: 6, epic: 120, legendary: 2400)
        case .magical: return (rare: 5, epic: 500, legendary: 10000)
        case .giant: return (rare: 5, epic: 10, legendary: 300)
        case .megaLightning: return (rare: 5, epic: 30, legendary: 600)
        case .lightning: return (rare: 5, epic: 15, legendary: 400)
        case .kings: return (rare: 6, epic: 50, legendary: 8000)
        case .epic: return (rare: 0, epic: 0, legendary: 0)
        case .legendary: return (rare: 0, epic: 0, legendary: 0)
        }
    }
}

// MARK: -Contents Struct
extension DataSet.Chests {
    struct Contents: Hashable, Equatable {
        var commons: Double
        var rares: Double
        var epics: Double
        var legendaries: Double
        var chanceOfRare: Double
        var chanceOfEpic: Double
        var chanceOfLegendary: Double
        var golds: Double
        var goldsMax: Double
        var averageGolds: Double
        var strikes: Double
        
        private init(_ chanceFactors: (rare: Double, epic: Double, legendary: Double)? = nil,
             _ commons: Double = 0,
             _ rares: Double = 0,
             _ epics: Double = 0,
             _ legendaries: Double = 0,
             _ golds: Double = 0,
             _ golds2: Double = 0,
             strikes: Double = 0
        ) {
            let legendaryCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .legendary}.count)
            let epicCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .epic}.count)
            let rareCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .rare}.count)
            let commonCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .common}.count)
            let totalChestCards = commons + rares + epics + legendaries
            
            self.commons = commons
            self.rares = rares
            self.epics = epics
            self.legendaries = legendaries
            
            if let factors = chanceFactors {
                let rari = (totalChestCards*rareCards)/(commonCards*factors.rare)
                self.chanceOfRare = factors.rare == 0 ? 0 : rari > 1 ? 1 : rari
                let epici = (totalChestCards*epicCards)/(commonCards*factors.epic)
                self.chanceOfEpic = factors.epic == 0 ? 0 : epici > 1 ? 1 : epici
                let legendi = (totalChestCards*legendaryCards)/(commonCards*factors.legendary)
                self.chanceOfLegendary = legendaries > 0 ? 0 : factors.legendary == 0 ? 0 : legendi > 1 ? 1 : legendi
            }
            else {
                self.chanceOfRare = 0
                self.chanceOfEpic = 0
                self.chanceOfLegendary = 0
            }
            
            self.golds = golds
            if golds2 == 0 {
                self.goldsMax = golds
                self.averageGolds = golds
            }
            else {
                self.goldsMax = golds2
                self.averageGolds = (golds+golds2)/2
            }
            self.strikes = strikes
        }
        
        private init(_ commons: Double,
             _ rares: Double,
             _ epics: Double,
             _ legendaries: Double,
             _ averageGold: Double,
             _ chanceOfRare: Double,
             _ chanceOfEpic: Double,
             _ chanceOfLegendary: Double,
             _ initDifference: Any // not important. makes initializers have a difference so xcode can identify them
        ) {
            self.commons = commons
            self.rares = rares
            self.epics = epics
            self.legendaries = legendaries
            self.averageGolds = averageGold
            self.chanceOfRare = chanceOfRare
            self.chanceOfEpic = chanceOfEpic
            self.chanceOfLegendary = chanceOfLegendary
            
            self.strikes = 0
            self.golds = 0
            self.goldsMax = 0
        }
        
        init(_ chest: DataSet.Chests,
             _ commons: Double = 0,
             _ rares: Double = 0,
             _ epics: Double = 0,
             _ legendaries: Double = 0,
             _ golds: Double = 0,
             _ golds2: Double = 0,
             strikes: Double = 0
        ) {
            let chanceFactors = chest.chanceFactor
            let legendaryCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .legendary}.count)
            let epicCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .epic}.count)
            let rareCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .rare}.count)
            let commonCards = Double(DataSet.Cards.allValids.filter{$0.info.rarity == .common}.count)
            let totalChestCards = commons + rares + epics + legendaries
            
            self.commons = commons
            self.rares = rares
            self.epics = epics
            self.legendaries = legendaries
            
             // using chance factors
                let rari = (totalChestCards*rareCards)/(commonCards*chanceFactors.rare)
                self.chanceOfRare = chanceFactors.rare == 0 ? 0 : rari > 1 ? 1 : rari
                let epici = (totalChestCards*epicCards)/(commonCards*chanceFactors.epic)
                self.chanceOfEpic = chanceFactors.epic == 0 ? 0 : epici > 1 ? 1 : epici
                let legendi = (totalChestCards*legendaryCards)/(commonCards*chanceFactors.legendary)
                self.chanceOfLegendary = legendaries > 0 ? 0 : chanceFactors.legendary == 0 ? 0 : legendi > 1 ? 1 : legendi
            
            self.golds = golds
            if golds2 == 0 {
                self.goldsMax = golds
                self.averageGolds = golds
            }
            else {
                self.goldsMax = golds2
                self.averageGolds = (golds+golds2)/2
            }
            self.strikes = strikes
            
        }
        
        static func challengeChest(_ commons: Double = 0,
                                   _ rares: Double = 0,
                                   _ epics: Double = 0,
                                   _ legendaries: Double = 0,
                                   _ golds: Double = 0) -> Self {
            
            let epicCount: (Double) -> (Double) = { return $0/100 }
            let rareCount: (Double) -> (Double) = { return $0/10 }
            let commonCount: (Double) -> (Double) = { return ($0 - epicCount($0) - rareCount($0)) }
            
            return Self(DataSet.Chests.grandChallenge(wins: 0).chanceFactor,
                        commonCount(commons),
                        rareCount(rares),
                        epicCount(epics),
                        legendaries,
                        golds)
        }
        
    }
}
