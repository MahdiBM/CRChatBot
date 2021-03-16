import Foundation

extension DataSet.Regions {
    struct Region: Codable {
        var id: Int
        var key: String
        var name: String
        var isCountry: Bool
        var emoji: String
    }
}

extension DataSet {
    enum Regions: String, Codable, CaseIterable {
        case All = "All"
        case _EU = "_EU"
        case _NA = "_NA"
        case _SA = "_SA"
        case _AS = "_AS"
        case _AU = "_AU"
        case _AF = "_AF"
        case _INT = "_INT"
        case AF = "AF"
        case AX = "AX"
        case AL = "AL"
        case DZ = "DZ"
        case AS = "AS"
        case AD = "AD"
        case AO = "AO"
        case AI = "AI"
        case AQ = "AQ"
        case AG = "AG"
        case AR = "AR"
        case AM = "AM"
        case AW = "AW"
        case AC = "AC"
        case AU = "AU"
        case AT = "AT"
        case AZ = "AZ"
        case BS = "BS"
        case BH = "BH"
        case BD = "BD"
        case BB = "BB"
        case BY = "BY"
        case BE = "BE"
        case BZ = "BZ"
        case BJ = "BJ"
        case BM = "BM"
        case BT = "BT"
        case BO = "BO"
        case BA = "BA"
        case BW = "BW"
        case BV = "BV"
        case BR = "BR"
        case IO = "IO"
        case VG = "VG"
        case BN = "BN"
        case BG = "BG"
        case BF = "BF"
        case BI = "BI"
        case KH = "KH"
        case CM = "CM"
        case CA = "CA"
        case IC = "IC"
        case CV = "CV"
        case BQ = "BQ"
        case KY = "KY"
        case CF = "CF"
        case EA = "EA"
        case TD = "TD"
        case CL = "CL"
        case CN = "CN"
        case CX = "CX"
        case CC = "CC"
        case CO = "CO"
        case KM = "KM"
        case CG = "CG"
        case CD = "CD"
        case CK = "CK"
        case CR = "CR"
        case CI = "CI"
        case HR = "HR"
        case CU = "CU"
        case CW = "CW"
        case CY = "CY"
        case CZ = "CZ"
        case DK = "DK"
        case DG = "DG"
        case DJ = "DJ"
        case DM = "DM"
        case DO = "DO"
        case EC = "EC"
        case EG = "EG"
        case SV = "SV"
        case GQ = "GQ"
        case ER = "ER"
        case EE = "EE"
        case ET = "ET"
        case FK = "FK"
        case FO = "FO"
        case FJ = "FJ"
        case FI = "FI"
        case FR = "FR"
        case GF = "GF"
        case PF = "PF"
        case TF = "TF"
        case GA = "GA"
        case GM = "GM"
        case GE = "GE"
        case DE = "DE"
        case GH = "GH"
        case GI = "GI"
        case GR = "GR"
        case GL = "GL"
        case GD = "GD"
        case GP = "GP"
        case GU = "GU"
        case GT = "GT"
        case GG = "GG"
        case GN = "GN"
        case GW = "GW"
        case GY = "GY"
        case HT = "HT"
        case HM = "HM"
        case HN = "HN"
        case HK = "HK"
        case HU = "HU"
        case IS = "IS"
        case IN = "IN"
        case ID = "ID"
        case IR = "IR"
        case IQ = "IQ"
        case IE = "IE"
        case IM = "IM"
        case IL = "IL"
        case IT = "IT"
        case JM = "JM"
        case JP = "JP"
        case JE = "JE"
        case JO = "JO"
        case KZ = "KZ"
        case KE = "KE"
        case KI = "KI"
        case XK = "XK"
        case KW = "KW"
        case KG = "KG"
        case LA = "LA"
        case LV = "LV"
        case LB = "LB"
        case LS = "LS"
        case LR = "LR"
        case LY = "LY"
        case LI = "LI"
        case LT = "LT"
        case LU = "LU"
        case MO = "MO"
        case MK = "MK"
        case MG = "MG"
        case MW = "MW"
        case MY = "MY"
        case MV = "MV"
        case ML = "ML"
        case MT = "MT"
        case MH = "MH"
        case MQ = "MQ"
        case MR = "MR"
        case MU = "MU"
        case YT = "YT"
        case MX = "MX"
        case FM = "FM"
        case MD = "MD"
        case MC = "MC"
        case MN = "MN"
        case ME = "ME"
        case MS = "MS"
        case MA = "MA"
        case MZ = "MZ"
        case MM = "MM"
        case NA = "NA"
        case NR = "NR"
        case NP = "NP"
        case NL = "NL"
        case NC = "NC"
        case NZ = "NZ"
        case NI = "NI"
        case NE = "NE"
        case NG = "NG"
        case NU = "NU"
        case NF = "NF"
        case KP = "KP"
        case MP = "MP"
        case NO = "NO"
        case OM = "OM"
        case PK = "PK"
        case PW = "PW"
        case PS = "PS"
        case PA = "PA"
        case PG = "PG"
        case PY = "PY"
        case PE = "PE"
        case PH = "PH"
        case PN = "PN"
        case PL = "PL"
        case PT = "PT"
        case PR = "PR"
        case QA = "QA"
        case RE = "RE"
        case RO = "RO"
        case RU = "RU"
        case RW = "RW"
        case BL = "BL"
        case SH = "SH"
        case KN = "KN"
        case LC = "LC"
        case MF = "MF"
        case PM = "PM"
        case WS = "WS"
        case SM = "SM"
        case ST = "ST"
        case SA = "SA"
        case SN = "SN"
        case RS = "RS"
        case SC = "SC"
        case SL = "SL"
        case SG = "SG"
        case SX = "SX"
        case SK = "SK"
        case SI = "SI"
        case SB = "SB"
        case SO = "SO"
        case ZA = "ZA"
        case KR = "KR"
        case SS = "SS"
        case ES = "ES"
        case LK = "LK"
        case VC = "VC"
        case SD = "SD"
        case SR = "SR"
        case SJ = "SJ"
        case SZ = "SZ"
        case SE = "SE"
        case CH = "CH"
        case SY = "SY"
        case TW = "TW"
        case TJ = "TJ"
        case TZ = "TZ"
        case TH = "TH"
        case TL = "TL"
        case TG = "TG"
        case TK = "TK"
        case TO = "TO"
        case TT = "TT"
        case TA = "TA"
        case TN = "TN"
        case TR = "TR"
        case TM = "TM"
        case TC = "TC"
        case TV = "TV"
        case UM = "UM"
        case VI = "VI"
        case UG = "UG"
        case UA = "UA"
        case AE = "AE"
        case GB = "GB"
        case US = "US"
        case UY = "UY"
        case UZ = "UZ"
        case VU = "VU"
        case VA = "VA"
        case VE = "VE"
        case VN = "VN"
        case WF = "WF"
        case EH = "EH"
        case YE = "YE"
        case ZM = "ZM"
        case ZW = "ZW"
    }
}

extension DataSet.Regions {
    var value: Region {
        switch self {
        case .All: return Region(id: 00000000,
                                key: "All",
                                name: "Global",
                                isCountry: false,
                                emoji: "🌐")
        case ._EU: return Region(id: 57000000,
                               key: "_EU",
                               name: "Europe",
                               isCountry: false,
                               emoji: "🌍")
        case ._NA: return Region(id: 57000001,
                               key: "_NA",
                               name: "North America",
                               isCountry: false,
                               emoji: "🌎")
        case ._SA: return Region(id: 57000002,
                               key: "_SA",
                               name: "South America",
                               isCountry: false,
                               emoji: "🌎")
        case ._AS: return Region(id: 57000003,
                               key: "_AS",
                               name: "Asia",
                               isCountry: false,
                               emoji: "🌏")
        case ._AU: return Region(id: 57000004,
                               key: "_AU",
                               name: "Oceania",
                               isCountry: false,
                               emoji: "🌏")
        case ._AF: return Region(id: 57000005,
                               key: "_AF",
                               name: "Africa",
                               isCountry: false,
                               emoji: "🌍")
        case ._INT: return Region(id: 57000006,
                                key: "_INT",
                                name: "International",
                                isCountry: false,
                                emoji: "🇺🇳")
        case .AF: return Region(id: 57000007,
                              key: "AF",
                              name: "Afghanistan",
                              isCountry: true,
                              emoji: "🇦🇫")
        case .AX: return Region(id: 57000008,
                              key: "AX",
                              name: "Åland Islands",
                              isCountry: true,
                              emoji: "🇦🇽")
        case .AL: return Region(id: 57000009,
                              key: "AL",
                              name: "Albania",
                              isCountry: true,
                              emoji: "🇦🇱")
        case .DZ: return Region(id: 57000010,
                              key: "DZ",
                              name: "Algeria",
                              isCountry: true,
                              emoji: "🇩🇿")
        case .AS: return Region(id: 57000011,
                              key: "AS",
                              name: "American Samoa",
                              isCountry: true,
                              emoji: "🇦🇸")
        case .AD: return Region(id: 57000012,
                              key: "AD",
                              name: "Andorra",
                              isCountry: true,
                              emoji: "🇦🇩")
        case .AO: return Region(id: 57000013,
                              key: "AO",
                              name: "Angola",
                              isCountry: true,
                              emoji: "🇦🇴")
        case .AI: return Region(id: 57000014,
                              key: "AI",
                              name: "Anguilla",
                              isCountry: true,
                              emoji: "🇦🇮")
        case .AQ: return Region(id: 57000015,
                              key: "AQ",
                              name: "Antarctica",
                              isCountry: true,
                              emoji: "🇦🇶")
        case .AG: return Region(id: 57000016,
                              key: "AG",
                              name: "Antigua and Barbuda",
                              isCountry: true,
                              emoji: "🇦🇬")
        case .AR: return Region(id: 57000017,
                              key: "AR",
                              name: "Argentina",
                              isCountry: true,
                              emoji: "🇦🇷")
        case .AM: return Region(id: 57000018,
                              key: "AM",
                              name: "Armenia",
                              isCountry: true,
                              emoji: "🇦🇲")
        case .AW: return Region(id: 57000019,
                              key: "AW",
                              name: "Aruba",
                              isCountry: true,
                              emoji: "🇦🇼")
        case .AC: return Region(id: 57000020,
                              key: "AC",
                              name: "Ascension Island",
                              isCountry: true,
                              emoji: "🇦🇨")
        case .AU: return Region(id: 57000021,
                              key: "AU",
                              name: "Australia",
                              isCountry: true,
                              emoji: "🇦🇺")
        case .AT: return Region(id: 57000022,
                              key: "AT",
                              name: "Austria",
                              isCountry: true,
                              emoji: "🇦🇹")
        case .AZ: return Region(id: 57000023,
                              key: "AZ",
                              name: "Azerbaijan",
                              isCountry: true,
                              emoji: "🇦🇿")
        case .BS: return Region(id: 57000024,
                              key: "BS",
                              name: "Bahamas",
                              isCountry: true,
                              emoji: "🇧🇸")
        case .BH: return Region(id: 57000025,
                              key: "BH",
                              name: "Bahrain",
                              isCountry: true,
                              emoji: "🇧🇭")
        case .BD: return Region(id: 57000026,
                              key: "BD",
                              name: "Bangladesh",
                              isCountry: true,
                              emoji: "🇧🇩")
        case .BB: return Region(id: 57000027,
                              key: "BB",
                              name: "Barbados",
                              isCountry: true,
                              emoji: "🇧🇧")
        case .BY: return Region(id: 57000028,
                              key: "BY",
                              name: "Belarus",
                              isCountry: true,
                              emoji: "🇧🇾")
        case .BE: return Region(id: 57000029,
                              key: "BE",
                              name: "Belgium",
                              isCountry: true,
                              emoji: "🇧🇪")
        case .BZ: return Region(id: 57000030,
                              key: "BZ",
                              name: "Belize",
                              isCountry: true,
                              emoji: "🇧🇿")
        case .BJ: return Region(id: 57000031,
                              key: "BJ",
                              name: "Benin",
                              isCountry: true,
                              emoji: "🇧🇯")
        case .BM: return Region(id: 57000032,
                              key: "BM",
                              name: "Bermuda",
                              isCountry: true,
                              emoji: "🇧🇲")
        case .BT: return Region(id: 57000033,
                              key: "BT",
                              name: "Bhutan",
                              isCountry: true,
                              emoji: "🇧🇹")
        case .BO: return Region(id: 57000034,
                              key: "BO",
                              name: "Bolivia",
                              isCountry: true,
                              emoji: "🇧🇴")
        case .BA: return Region(id: 57000035,
                              key: "BA",
                              name: "Bosnia and Herzegovina",
                              isCountry: true,
                              emoji: "🇧🇦")
        case .BW: return Region(id: 57000036,
                              key: "BW",
                              name: "Botswana",
                              isCountry: true,
                              emoji: "🇧🇼")
        case .BV: return Region(id: 57000037,
                              key: "BV",
                              name: "Bouvet Island",
                              isCountry: true,
                              emoji: "🇧🇻")
        case .BR: return Region(id: 57000038,
                              key: "BR",
                              name: "Brazil",
                              isCountry: true,
                              emoji: "🇧🇷")
        case .IO: return Region(id: 57000039,
                              key: "IO",
                              name: "British Indian Ocean Territory",
                              isCountry: true,
                              emoji: "🇮🇴")
        case .VG: return Region(id: 57000040,
                              key: "VG",
                              name: "British Virgin Islands",
                              isCountry: true,
                              emoji: "🇻🇬")
        case .BN: return Region(id: 57000041,
                              key: "BN",
                              name: "Brunei",
                              isCountry: true,
                              emoji: "🇧🇳")
        case .BG: return Region(id: 57000042,
                              key: "BG",
                              name: "Bulgaria",
                              isCountry: true,
                              emoji: "🇧🇬")
        case .BF: return Region(id: 57000043,
                              key: "BF",
                              name: "Burkina Faso",
                              isCountry: true,
                              emoji: "🇧🇫")
        case .BI: return Region(id: 57000044,
                              key: "BI",
                              name: "Burundi",
                              isCountry: true,
                              emoji: "🇧🇮")
        case .KH: return Region(id: 57000045,
                              key: "KH",
                              name: "Cambodia",
                              isCountry: true,
                              emoji: "🇰🇭")
        case .CM: return Region(id: 57000046,
                              key: "CM",
                              name: "Cameroon",
                              isCountry: true,
                              emoji: "🇨🇲")
        case .CA: return Region(id: 57000047,
                              key: "CA",
                              name: "Canada",
                              isCountry: true,
                              emoji: "🇨🇦")
        case .IC: return Region(id: 57000048,
                              key: "IC",
                              name: "Canary Islands",
                              isCountry: true,
                              emoji: "🇮🇨")
        case .CV: return Region(id: 57000049,
                              key: "CV",
                              name: "Cape Verde",
                              isCountry: true,
                              emoji: "🇨🇻")
        case .BQ: return Region(id: 57000050,
                              key: "BQ",
                              name: "Caribbean Netherlands",
                              isCountry: true,
                              emoji: "🇧🇶")
        case .KY: return Region(id: 57000051,
                              key: "KY",
                              name: "Cayman Islands",
                              isCountry: true,
                              emoji: "🇰🇾")
        case .CF: return Region(id: 57000052,
                              key: "CF",
                              name: "Central African Republic",
                              isCountry: true,
                              emoji: "🇨🇫")
        case .EA: return Region(id: 57000053,
                              key: "EA",
                              name: "Ceuta and Melilla",
                              isCountry: true,
                              emoji: "🇪🇦")
        case .TD: return Region(id: 57000054,
                              key: "TD",
                              name: "Chad",
                              isCountry: true,
                              emoji: "🇹🇩")
        case .CL: return Region(id: 57000055,
                              key: "CL",
                              name: "Chile",
                              isCountry: true,
                              emoji: "🇨🇱")
        case .CN: return Region(id: 57000056,
                              key: "CN",
                              name: "China",
                              isCountry: true,
                              emoji: "🇨🇳")
        case .CX: return Region(id: 57000057,
                              key: "CX",
                              name: "Christmas Island",
                              isCountry: true,
                              emoji: "🇨🇽")
        case .CC: return Region(id: 57000058,
                              key: "CC",
                              name: "Cocos (Keeling) Islands",
                              isCountry: true,
                              emoji: "🇨🇨")
        case .CO: return Region(id: 57000059,
                              key: "CO",
                              name: "Colombia",
                              isCountry: true,
                              emoji: "🇨🇴")
        case .KM: return Region(id: 57000060,
                              key: "KM",
                              name: "Comoros",
                              isCountry: true,
                              emoji: "🇰🇲")
        case .CG: return Region(id: 57000061,
                              key: "CG",
                              name: "Congo (DRC)",
                              isCountry: true,
                              emoji: "🇨🇩")
        case .CD: return Region(id: 57000062,
                              key: "CD",
                              name: "Congo (Republic)",
                              isCountry: true,
                              emoji: "🇨🇬")
        case .CK: return Region(id: 57000063,
                              key: "CK",
                              name: "Cook Islands",
                              isCountry: true,
                              emoji: "🇨🇰")
        case .CR: return Region(id: 57000064,
                              key: "CR",
                              name: "Costa Rica",
                              isCountry: true,
                              emoji: "🇨🇷")
        case .CI: return Region(id: 57000065,
                              key: "CI",
                              name: "Côte d’Ivoire",
                              isCountry: true,
                              emoji: "🇨🇮")
        case .HR: return Region(id: 57000066,
                              key: "HR",
                              name: "Croatia",
                              isCountry: true,
                              emoji: "🇭🇷")
        case .CU: return Region(id: 57000067,
                              key: "CU",
                              name: "Cuba",
                              isCountry: true,
                              emoji: "🇨🇺")
        case .CW: return Region(id: 57000068,
                              key: "CW",
                              name: "Curaçao",
                              isCountry: true,
                              emoji: "🇨🇼")
        case .CY: return Region(id: 57000069,
                              key: "CY",
                              name: "Cyprus",
                              isCountry: true,
                              emoji: "🇨🇾")
        case .CZ: return Region(id: 57000070,
                              key: "CZ",
                              name: "Czech Republic",
                              isCountry: true,
                              emoji: "🇨🇿")
        case .DK: return Region(id: 57000071,
                              key: "DK",
                              name: "Denmark",
                              isCountry: true,
                              emoji: "🇩🇰")
        case .DG: return Region(id: 57000072,
                              key: "DG",
                              name: "Diego Garcia",
                              isCountry: true,
                              emoji: "🇩🇬")
        case .DJ: return Region(id: 57000073,
                              key: "DJ",
                              name: "Djibouti",
                              isCountry: true,
                              emoji: "🇩🇯")
        case .DM: return Region(id: 57000074,
                              key: "DM",
                              name: "Dominica",
                              isCountry: true,
                              emoji: "🇩🇲")
        case .DO: return Region(id: 57000075,
                              key: "DO",
                              name: "Dominican Republic",
                              isCountry: true,
                              emoji: "🇩🇴")
        case .EC: return Region(id: 57000076,
                              key: "EC",
                              name: "Ecuador",
                              isCountry: true,
                              emoji: "🇪🇨")
        case .EG: return Region(id: 57000077,
                              key: "EG",
                              name: "Egypt",
                              isCountry: true,
                              emoji: "🇪🇬")
        case .SV: return Region(id: 57000078,
                              key: "SV",
                              name: "El Salvador",
                              isCountry: true,
                              emoji: "🇸🇻")
        case .GQ: return Region(id: 57000079,
                              key: "GQ",
                              name: "Equatorial Guinea",
                              isCountry: true,
                              emoji: "🇬🇶")
        case .ER: return Region(id: 57000080,
                              key: "ER",
                              name: "Eritrea",
                              isCountry: true,
                              emoji: "🇪🇷")
        case .EE: return Region(id: 57000081,
                              key: "EE",
                              name: "Estonia",
                              isCountry: true,
                              emoji: "🇪🇪")
        case .ET: return Region(id: 57000082,
                              key: "ET",
                              name: "Ethiopia",
                              isCountry: true,
                              emoji: "🇪🇹")
        case .FK: return Region(id: 57000083,
                              key: "FK",
                              name: "Falkland Islands",
                              isCountry: true,
                              emoji: "🇫🇰")
        case .FO: return Region(id: 57000084,
                              key: "FO",
                              name: "Faroe Islands",
                              isCountry: true,
                              emoji: "🇫🇴")
        case .FJ: return Region(id: 57000085,
                              key: "FJ",
                              name: "Fiji",
                              isCountry: true,
                              emoji: "🇫🇯")
        case .FI: return Region(id: 57000086,
                              key: "FI",
                              name: "Finland",
                              isCountry: true,
                              emoji: "🇫🇮")
        case .FR: return Region(id: 57000087,
                              key: "FR",
                              name: "France",
                              isCountry: true,
                              emoji: "🇫🇷")
        case .GF: return Region(id: 57000088,
                              key: "GF",
                              name: "French Guiana",
                              isCountry: true,
                              emoji: "🇬🇫")
        case .PF: return Region(id: 57000089,
                              key: "PF",
                              name: "French Polynesia",
                              isCountry: true,
                              emoji: "🇵🇫")
        case .TF: return Region(id: 57000090,
                              key: "TF",
                              name: "French Southern Territories",
                              isCountry: true,
                              emoji: "🇹🇫")
        case .GA: return Region(id: 57000091,
                              key: "GA",
                              name: "Gabon",
                              isCountry: true,
                              emoji: "🇬🇦")
        case .GM: return Region(id: 57000092,
                              key: "GM",
                              name: "Gambia",
                              isCountry: true,
                              emoji: "🇬🇲")
        case .GE: return Region(id: 57000093,
                              key: "GE",
                              name: "Georgia",
                              isCountry: true,
                              emoji: "🇬🇪")
        case .DE: return Region(id: 57000094,
                              key: "DE",
                              name: "Germany",
                              isCountry: true,
                              emoji: "🇩🇪")
        case .GH: return Region(id: 57000095,
                              key: "GH",
                              name: "Ghana",
                              isCountry: true,
                              emoji: "🇬🇭")
        case .GI: return Region(id: 57000096,
                              key: "GI",
                              name: "Gibraltar",
                              isCountry: true,
                              emoji: "🇬🇮")
        case .GR: return Region(id: 57000097,
                              key: "GR",
                              name: "Greece",
                              isCountry: true,
                              emoji: "🇬🇷")
        case .GL: return Region(id: 57000098,
                              key: "GL",
                              name: "Greenland",
                              isCountry: true,
                              emoji: "🇬🇱")
        case .GD: return Region(id: 57000099,
                              key: "GD",
                              name: "Grenada",
                              isCountry: true,
                              emoji: "🇬🇩")
        case .GP: return Region(id: 57000100,
                              key: "GP",
                              name: "Guadeloupe",
                              isCountry: true,
                              emoji: "🇬🇵")
        case .GU: return Region(id: 57000101,
                              key: "GU",
                              name: "Guam",
                              isCountry: true,
                              emoji: "🇬🇺")
        case .GT: return Region(id: 57000102,
                              key: "GT",
                              name: "Guatemala",
                              isCountry: true,
                              emoji: "🇬🇹")
        case .GG: return Region(id: 57000103,
                              key: "GG",
                              name: "Guernsey",
                              isCountry: true,
                              emoji: "🇬🇬")
        case .GN: return Region(id: 57000104,
                              key: "GN",
                              name: "Guinea",
                              isCountry: true,
                              emoji: "🇬🇳")
        case .GW: return Region(id: 57000105,
                              key: "GW",
                              name: "Guinea-Bissau",
                              isCountry: true,
                              emoji: "🇬🇼")
        case .GY: return Region(id: 57000106,
                              key: "GY",
                              name: "Guyana",
                              isCountry: true,
                              emoji: "🇬🇾")
        case .HT: return Region(id: 57000107,
                              key: "HT",
                              name: "Haiti",
                              isCountry: true,
                              emoji: "🇭🇹")
        case .HM: return Region(id: 57000108,
                              key: "HM",
                              name: "Heard & McDonald Islands",
                              isCountry: true,
                              emoji: "🇭🇲")
        case .HN: return Region(id: 57000109,
                              key: "HN",
                              name: "Honduras",
                              isCountry: true,
                              emoji: "🇭🇳")
        case .HK: return Region(id: 57000110,
                              key: "HK",
                              name: "Hong Kong",
                              isCountry: true,
                              emoji: "🇭🇰")
        case .HU: return Region(id: 57000111,
                              key: "HU",
                              name: "Hungary",
                              isCountry: true,
                              emoji: "🇭🇺")
        case .IS: return Region(id: 57000112,
                              key: "IS",
                              name: "Iceland",
                              isCountry: true,
                              emoji: "🇮🇸")
        case .IN: return Region(id: 57000113,
                              key: "IN",
                              name: "India",
                              isCountry: true,
                              emoji: "🇮🇳")
        case .ID: return Region(id: 57000114,
                              key: "ID",
                              name: "Indonesia",
                              isCountry: true,
                              emoji: "🇮🇩")
        case .IR: return Region(id: 57000115,
                              key: "IR",
                              name: "Iran",
                              isCountry: true,
                              emoji: "🇮🇷")
        case .IQ: return Region(id: 57000116,
                              key: "IQ",
                              name: "Iraq",
                              isCountry: true,
                              emoji: "🇮🇶")
        case .IE: return Region(id: 57000117,
                              key: "IE",
                              name: "Ireland",
                              isCountry: true,
                              emoji: "🇮🇪")
        case .IM: return Region(id: 57000118,
                              key: "IM",
                              name: "Isle of Man",
                              isCountry: true,
                              emoji: "🇮🇲")
        case .IL: return Region(id: 57000119,
                              key: "IL",
                              name: "Israel",
                              isCountry: true,
                              emoji: "🇮🇱")
        case .IT: return Region(id: 57000120,
                              key: "IT",
                              name: "Italy",
                              isCountry: true,
                              emoji: "🇮🇹")
        case .JM: return Region(id: 57000121,
                              key: "JM",
                              name: "Jamaica",
                              isCountry: true,
                              emoji: "🇯🇲")
        case .JP: return Region(id: 57000122,
                              key: "JP",
                              name: "Japan",
                              isCountry: true,
                              emoji: "🇯🇵")
        case .JE: return Region(id: 57000123,
                              key: "JE",
                              name: "Jersey",
                              isCountry: true,
                              emoji: "🇯🇪")
        case .JO: return Region(id: 57000124,
                              key: "JO",
                              name: "Jordan",
                              isCountry: true,
                              emoji: "🇯🇴")
        case .KZ: return Region(id: 57000125,
                              key: "KZ",
                              name: "Kazakhstan",
                              isCountry: true,
                              emoji: "🇰🇿")
        case .KE: return Region(id: 57000126,
                              key: "KE",
                              name: "Kenya",
                              isCountry: true,
                              emoji: "🇰🇪")
        case .KI: return Region(id: 57000127,
                              key: "KI",
                              name: "Kiribati",
                              isCountry: true,
                              emoji: "🇰🇮")
        case .XK: return Region(id: 57000128,
                              key: "XK",
                              name: "Kosovo",
                              isCountry: true,
                              emoji: "🇽🇰")
        case .KW: return Region(id: 57000129,
                              key: "KW",
                              name: "Kuwait",
                              isCountry: true,
                              emoji: "🇰🇼")
        case .KG: return Region(id: 57000130,
                              key: "KG",
                              name: "Kyrgyzstan",
                              isCountry: true,
                              emoji: "🇰🇬")
        case .LA: return Region(id: 57000131,
                              key: "LA",
                              name: "Laos",
                              isCountry: true,
                              emoji: "🇱🇦")
        case .LV: return Region(id: 57000132,
                              key: "LV",
                              name: "Latvia",
                              isCountry: true,
                              emoji: "🇱🇻")
        case .LB: return Region(id: 57000133,
                              key: "LB",
                              name: "Lebanon",
                              isCountry: true,
                              emoji: "🇱🇧")
        case .LS: return Region(id: 57000134,
                              key: "LS",
                              name: "Lesotho",
                              isCountry: true,
                              emoji: "🇱🇸")
        case .LR: return Region(id: 57000135,
                              key: "LR",
                              name: "Liberia",
                              isCountry: true,
                              emoji: "🇱🇷")
        case .LY: return Region(id: 57000136,
                              key: "LY",
                              name: "Libya",
                              isCountry: true,
                              emoji: "🇱🇾")
        case .LI: return Region(id: 57000137,
                              key: "LI",
                              name: "Liechtenstein",
                              isCountry: true,
                              emoji: "🇱🇮")
        case .LT: return Region(id: 57000138,
                              key: "LT",
                              name: "Lithuania",
                              isCountry: true,
                              emoji: "🇱🇹")
        case .LU: return Region(id: 57000139,
                              key: "LU",
                              name: "Luxembourg",
                              isCountry: true,
                              emoji: "🇱🇺")
        case .MO: return Region(id: 57000140,
                              key: "MO",
                              name: "Macau",
                              isCountry: true,
                              emoji: "🇲🇴")
        case .MK: return Region(id: 57000141,
                              key: "MK",
                              name: "Macedonia (FYROM)",
                              isCountry: true,
                              emoji: "🇲🇰")
        case .MG: return Region(id: 57000142,
                              key: "MG",
                              name: "Madagascar",
                              isCountry: true,
                              emoji: "🇲🇬")
        case .MW: return Region(id: 57000143,
                              key: "MW",
                              name: "Malawi",
                              isCountry: true,
                              emoji: "🇲🇼")
        case .MY: return Region(id: 57000144,
                              key: "MY",
                              name: "Malaysia",
                              isCountry: true,
                              emoji: "🇲🇾")
        case .MV: return Region(id: 57000145,
                              key: "MV",
                              name: "Maldives",
                              isCountry: true,
                              emoji: "🇲🇻")
        case .ML: return Region(id: 57000146,
                              key: "ML",
                              name: "Mali",
                              isCountry: true,
                              emoji: "🇲🇱")
        case .MT: return Region(id: 57000147,
                              key: "MT",
                              name: "Malta",
                              isCountry: true,
                              emoji: "🇲🇹")
        case .MH: return Region(id: 57000148,
                              key: "MH",
                              name: "Marshall Islands",
                              isCountry: true,
                              emoji: "🇲🇭")
        case .MQ: return Region(id: 57000149,
                              key: "MQ",
                              name: "Martinique",
                              isCountry: true,
                              emoji: "🇲🇶")
        case .MR: return Region(id: 57000150,
                              key: "MR",
                              name: "Mauritania",
                              isCountry: true,
                              emoji: "🇲🇷")
        case .MU: return Region(id: 57000151,
                              key: "MU",
                              name: "Mauritius",
                              isCountry: true,
                              emoji: "🇲🇺")
        case .YT: return Region(id: 57000152,
                              key: "YT",
                              name: "Mayotte",
                              isCountry: true,
                              emoji: "🇾🇹")
        case .MX: return Region(id: 57000153,
                              key: "MX",
                              name: "Mexico",
                              isCountry: true,
                              emoji: "🇲🇽")
        case .FM: return Region(id: 57000154,
                              key: "FM",
                              name: "Micronesia",
                              isCountry: true,
                              emoji: "🇫🇲")
        case .MD: return Region(id: 57000155,
                              key: "MD",
                              name: "Moldova",
                              isCountry: true,
                              emoji: "🇲🇩")
        case .MC: return Region(id: 57000156,
                              key: "MC",
                              name: "Monaco",
                              isCountry: true,
                              emoji: "🇲🇨")
        case .MN: return Region(id: 57000157,
                              key: "MN",
                              name: "Mongolia",
                              isCountry: true,
                              emoji: "🇲🇳")
        case .ME: return Region(id: 57000158,
                              key: "ME",
                              name: "Montenegro",
                              isCountry: true,
                              emoji: "🇲🇪")
        case .MS: return Region(id: 57000159,
                              key: "MS",
                              name: "Montserrat",
                              isCountry: true,
                              emoji: "🇲🇸")
        case .MA: return Region(id: 57000160,
                              key: "MA",
                              name: "Morocco",
                              isCountry: true,
                              emoji: "🇲🇦")
        case .MZ: return Region(id: 57000161,
                              key: "MZ",
                              name: "Mozambique",
                              isCountry: true,
                              emoji: "🇲🇿")
        case .MM: return Region(id: 57000162,
                              key: "MM",
                              name: "Myanmar (Burma)",
                              isCountry: true,
                              emoji: "🇲🇲")
        case .NA: return Region(id: 57000163,
                              key: "NA",
                              name: "Namibia",
                              isCountry: true,
                              emoji: "🇳🇦")
        case .NR: return Region(id: 57000164,
                              key: "NR",
                              name: "Nauru",
                              isCountry: true,
                              emoji: "🇳🇷")
        case .NP: return Region(id: 57000165,
                              key: "NP",
                              name: "Nepal",
                              isCountry: true,
                              emoji: "🇳🇵")
        case .NL: return Region(id: 57000166,
                              key: "NL",
                              name: "Netherlands",
                              isCountry: true,
                              emoji: "🇳🇱")
        case .NC: return Region(id: 57000167,
                              key: "NC",
                              name: "New Caledonia",
                              isCountry: true,
                              emoji: "🇳🇨")
        case .NZ: return Region(id: 57000168,
                              key: "NZ",
                              name: "New Zealand",
                              isCountry: true,
                              emoji: "🇳🇿")
        case .NI: return Region(id: 57000169,
                              key: "NI",
                              name: "Nicaragua",
                              isCountry: true,
                              emoji: "🇳🇮")
        case .NE: return Region(id: 57000170,
                              key: "NE",
                              name: "Niger",
                              isCountry: true,
                              emoji: "🇳🇪")
        case .NG: return Region(id: 57000171,
                              key: "NG",
                              name: "Nigeria",
                              isCountry: true,
                              emoji: "🇳🇬")
        case .NU: return Region(id: 57000172,
                              key: "NU",
                              name: "Niue",
                              isCountry: true,
                              emoji: "🇳🇺")
        case .NF: return Region(id: 57000173,
                              key: "NF",
                              name: "Norfolk Island",
                              isCountry: true,
                              emoji: "🇳🇫")
        case .KP: return Region(id: 57000174,
                              key: "KP",
                              name: "North Korea",
                              isCountry: true,
                              emoji: "🇰🇵")
        case .MP: return Region(id: 57000175,
                              key: "MP",
                              name: "Northern Mariana Islands",
                              isCountry: true,
                              emoji: "🇲🇵")
        case .NO: return Region(id: 57000176,
                              key: "NO",
                              name: "Norway",
                              isCountry: true,
                              emoji: "🇳🇴")
        case .OM: return Region(id: 57000177,
                              key: "OM",
                              name: "Oman",
                              isCountry: true,
                              emoji: "🇴🇲")
        case .PK: return Region(id: 57000178,
                              key: "PK",
                              name: "Pakistan",
                              isCountry: true,
                              emoji: "🇵🇰")
        case .PW: return Region(id: 57000179,
                              key: "PW",
                              name: "Palau",
                              isCountry: true,
                              emoji: "🇵🇼")
        case .PS: return Region(id: 57000180,
                              key: "PS",
                              name: "Palestine",
                              isCountry: true,
                              emoji: "🇵🇸")
        case .PA: return Region(id: 57000181,
                              key: "PA",
                              name: "Panama",
                              isCountry: true,
                              emoji: "🇵🇦")
        case .PG: return Region(id: 57000182,
                              key: "PG",
                              name: "Papua New Guinea",
                              isCountry: true,
                              emoji: "🇵🇬")
        case .PY: return Region(id: 57000183,
                              key: "PY",
                              name: "Paraguay",
                              isCountry: true,
                              emoji: "🇵🇾")
        case .PE: return Region(id: 57000184,
                              key: "PE",
                              name: "Peru",
                              isCountry: true,
                              emoji: "🇵🇪")
        case .PH: return Region(id: 57000185,
                              key: "PH",
                              name: "Philippines",
                              isCountry: true,
                              emoji: "🇵🇭")
        case .PN: return Region(id: 57000186,
                              key: "PN",
                              name: "Pitcairn Islands",
                              isCountry: true,
                              emoji: "🇵🇳")
        case .PL: return Region(id: 57000187,
                              key: "PL",
                              name: "Poland",
                              isCountry: true,
                              emoji: "🇵🇱")
        case .PT: return Region(id: 57000188,
                              key: "PT",
                              name: "Portugal",
                              isCountry: true,
                              emoji: "🇵🇹")
        case .PR: return Region(id: 57000189,
                              key: "PR",
                              name: "Puerto Rico",
                              isCountry: true,
                              emoji: "🇵🇷")
        case .QA: return Region(id: 57000190,
                              key: "QA",
                              name: "Qatar",
                              isCountry: true,
                              emoji: "🇶🇦")
        case .RE: return Region(id: 57000191,
                              key: "RE",
                              name: "Réunion",
                              isCountry: true,
                              emoji: "🇷🇪")
        case .RO: return Region(id: 57000192,
                              key: "RO",
                              name: "Romania",
                              isCountry: true,
                              emoji: "🇷🇴")
        case .RU: return Region(id: 57000193,
                              key: "RU",
                              name: "Russia",
                              isCountry: true,
                              emoji: "🇷🇺")
        case .RW: return Region(id: 57000194,
                              key: "RW",
                              name: "Rwanda",
                              isCountry: true,
                              emoji: "🇷🇼")
        case .BL: return Region(id: 57000195,
                              key: "BL",
                              name: "Saint Barthélemy",
                              isCountry: true,
                              emoji: "🇧🇱")
        case .SH: return Region(id: 57000196,
                              key: "SH",
                              name: "Saint Helena",
                              isCountry: true,
                              emoji: "🇸🇭")
        case .KN: return Region(id: 57000197,
                              key: "KN",
                              name: "Saint Kitts and Nevis",
                              isCountry: true,
                              emoji: "🇰🇳")
        case .LC: return Region(id: 57000198,
                              key: "LC",
                              name: "Saint Lucia",
                              isCountry: true,
                              emoji: "🇱🇨")
        case .MF: return Region(id: 57000199,
                              key: "MF",
                              name: "Saint Martin",
                              isCountry: true,
                              emoji: "🇲🇫")
        case .PM: return Region(id: 57000200,
                              key: "PM",
                              name: "Saint Pierre and Miquelon",
                              isCountry: true,
                              emoji: "🇵🇲")
        case .WS: return Region(id: 57000201,
                              key: "WS",
                              name: "Samoa",
                              isCountry: true,
                              emoji: "🇼🇸")
        case .SM: return Region(id: 57000202,
                              key: "SM",
                              name: "San Marino",
                              isCountry: true,
                              emoji: "🇸🇲")
        case .ST: return Region(id: 57000203,
                              key: "ST",
                              name: "São Tomé and Príncipe",
                              isCountry: true,
                              emoji: "🇸🇹")
        case .SA: return Region(id: 57000204,
                              key: "SA",
                              name: "Saudi Arabia",
                              isCountry: true,
                              emoji: "🇸🇦")
        case .SN: return Region(id: 57000205,
                              key: "SN",
                              name: "Senegal",
                              isCountry: true,
                              emoji: "🇸🇳")
        case .RS: return Region(id: 57000206,
                              key: "RS",
                              name: "Serbia",
                              isCountry: true,
                              emoji: "🇷🇸")
        case .SC: return Region(id: 57000207,
                              key: "SC",
                              name: "Seychelles",
                              isCountry: true,
                              emoji: "🇸🇨")
        case .SL: return Region(id: 57000208,
                              key: "SL",
                              name: "Sierra Leone",
                              isCountry: true,
                              emoji: "🇸🇱")
        case .SG: return Region(id: 57000209,
                              key: "SG",
                              name: "Singapore",
                              isCountry: true,
                              emoji: "🇸🇬")
        case .SX: return Region(id: 57000210,
                              key: "SX",
                              name: "Sint Maarten",
                              isCountry: true,
                              emoji: "🇸🇽")
        case .SK: return Region(id: 57000211,
                              key: "SK",
                              name: "Slovakia",
                              isCountry: true,
                              emoji: "🇸🇰")
        case .SI: return Region(id: 57000212,
                              key: "SI",
                              name: "Slovenia",
                              isCountry: true,
                              emoji: "🇸🇮")
        case .SB: return Region(id: 57000213,
                              key: "SB",
                              name: "Solomon Islands",
                              isCountry: true,
                              emoji: "🇸🇧")
        case .SO: return Region(id: 57000214,
                              key: "SO",
                              name: "Somalia",
                              isCountry: true,
                              emoji: "🇸🇴")
        case .ZA: return Region(id: 57000215,
                              key: "ZA",
                              name: "South Africa",
                              isCountry: true,
                              emoji: "🇿🇦")
        case .KR: return Region(id: 57000216,
                              key: "KR",
                              name: "South Korea",
                              isCountry: true,
                              emoji: "🇰🇷")
        case .SS: return Region(id: 57000217,
                              key: "SS",
                              name: "South Sudan",
                              isCountry: true,
                              emoji: "🇸🇸")
        case .ES: return Region(id: 57000218,
                              key: "ES",
                              name: "Spain",
                              isCountry: true,
                              emoji: "🇪🇸")
        case .LK: return Region(id: 57000219,
                              key: "LK",
                              name: "Sri Lanka",
                              isCountry: true,
                              emoji: "🇱🇰")
        case .VC: return Region(id: 57000220,
                              key: "VC",
                              name: "St. Vincent & Grenadines",
                              isCountry: true,
                              emoji: "🇻🇨")
        case .SD: return Region(id: 57000221,
                              key: "SD",
                              name: "Sudan",
                              isCountry: true,
                              emoji: "🇸🇩")
        case .SR: return Region(id: 57000222,
                              key: "SR",
                              name: "Suriname",
                              isCountry: true,
                              emoji: "🇸🇷")
        case .SJ: return Region(id: 57000223,
                              key: "SJ",
                              name: "Svalbard and Jan Mayen",
                              isCountry: true,
                              emoji: "🇸🇯")
        case .SZ: return Region(id: 57000224,
                              key: "SZ",
                              name: "Swaziland",
                              isCountry: true,
                              emoji: "🇸🇿")
        case .SE: return Region(id: 57000225,
                              key: "SE",
                              name: "Sweden",
                              isCountry: true,
                              emoji: "🇸🇪")
        case .CH: return Region(id: 57000226,
                              key: "CH",
                              name: "Switzerland",
                              isCountry: true,
                              emoji: "🇨🇭")
        case .SY: return Region(id: 57000227,
                              key: "SY",
                              name: "Syria",
                              isCountry: true,
                              emoji: "🇸🇾")
        case .TW: return Region(id: 57000228,
                              key: "TW",
                              name: "Taiwan",
                              isCountry: true,
                              emoji: "🇹🇼")
        case .TJ: return Region(id: 57000229,
                              key: "TJ",
                              name: "Tajikistan",
                              isCountry: true,
                              emoji: "🇹🇯")
        case .TZ: return Region(id: 57000230,
                              key: "TZ",
                              name: "Tanzania",
                              isCountry: true,
                              emoji: "🇹🇿")
        case .TH: return Region(id: 57000231,
                              key: "TH",
                              name: "Thailand",
                              isCountry: true,
                              emoji: "🇹🇭")
        case .TL: return Region(id: 57000232,
                              key: "TL",
                              name: "Timor-Leste",
                              isCountry: true,
                              emoji: "🇹🇱")
        case .TG: return Region(id: 57000233,
                              key: "TG",
                              name: "Togo",
                              isCountry: true,
                              emoji: "🇹🇬")
        case .TK: return Region(id: 57000234,
                              key: "TK",
                              name: "Tokelau",
                              isCountry: true,
                              emoji: "🇹🇰")
        case .TO: return Region(id: 57000235,
                              key: "TO",
                              name: "Tonga",
                              isCountry: true,
                              emoji: "🇹🇴")
        case .TT: return Region(id: 57000236,
                              key: "TT",
                              name: "Trinidad and Tobago",
                              isCountry: true,
                              emoji: "🇹🇹")
        case .TA: return Region(id: 57000237,
                              key: "TA",
                              name: "Tristan da Cunha",
                              isCountry: true,
                              emoji: "🇹🇦")
        case .TN: return Region(id: 57000238,
                              key: "TN",
                              name: "Tunisia",
                              isCountry: true,
                              emoji: "🇹🇳")
        case .TR: return Region(id: 57000239,
                              key: "TR",
                              name: "Turkey",
                              isCountry: true,
                              emoji: "🇹🇷")
        case .TM: return Region(id: 57000240,
                              key: "TM",
                              name: "Turkmenistan",
                              isCountry: true,
                              emoji: "🇹🇲")
        case .TC: return Region(id: 57000241,
                              key: "TC",
                              name: "Turks and Caicos Islands",
                              isCountry: true,
                              emoji: "🇹🇨")
        case .TV: return Region(id: 57000242,
                              key: "TV",
                              name: "Tuvalu",
                              isCountry: true,
                              emoji: "🇹🇻")
        case .UM: return Region(id: 57000243,
                              key: "UM",
                              name: "U.S. Outlying Islands",
                              isCountry: true,
                              emoji: "🏴󠁵󠁳󠁵󠁭󠁿")
        case .VI: return Region(id: 57000244,
                              key: "VI",
                              name: "U.S. Virgin Islands",
                              isCountry: true,
                              emoji: "🇻🇮")
        case .UG: return Region(id: 57000245,
                              key: "UG",
                              name: "Uganda",
                              isCountry: true,
                              emoji: "🇺🇬")
        case .UA: return Region(id: 57000246,
                              key: "UA",
                              name: "Ukraine",
                              isCountry: true,
                              emoji: "🇺🇦")
        case .AE: return Region(id: 57000247,
                              key: "AE",
                              name: "United Arab Emirates",
                              isCountry: true,
                              emoji: "🇦🇪")
        case .GB: return Region(id: 57000248,
                              key: "GB",
                              name: "United Kingdom",
                              isCountry: true,
                              emoji: "🇬🇧")
        case .US: return Region(id: 57000249,
                              key: "US",
                              name: "United States",
                              isCountry: true,
                              emoji: "🇺🇸")
        case .UY: return Region(id: 57000250,
                              key: "UY",
                              name: "Uruguay",
                              isCountry: true,
                              emoji: "🇺🇾")
        case .UZ: return Region(id: 57000251,
                              key: "UZ",
                              name: "Uzbekistan",
                              isCountry: true,
                              emoji: "🇺🇿")
        case .VU: return Region(id: 57000252,
                              key: "VU",
                              name: "Vanuatu",
                              isCountry: true,
                              emoji: "🇻🇺")
        case .VA: return Region(id: 57000253,
                              key: "VA",
                              name: "Vatican City",
                              isCountry: true,
                              emoji: "🇻🇦")
        case .VE: return Region(id: 57000254,
                              key: "VE",
                              name: "Venezuela",
                              isCountry: true,
                              emoji: "🇻🇪")
        case .VN: return Region(id: 57000255,
                              key: "VN",
                              name: "Vietnam",
                              isCountry: true,
                              emoji: "🇻🇳")
        case .WF: return Region(id: 57000256,
                              key: "WF",
                              name: "Wallis and Futuna",
                              isCountry: true,
                              emoji: "🇼🇫")
        case .EH: return Region(id: 57000257,
                              key: "EH",
                              name: "Western Sahara",
                              isCountry: true,
                              emoji: "🇪🇭")
        case .YE: return Region(id: 57000258,
                              key: "YE",
                              name: "Yemen",
                              isCountry: true,
                              emoji: "🇾🇪")
        case .ZM: return Region(id: 57000259,
                              key: "ZM",
                              name: "Zambia",
                              isCountry: true,
                              emoji: "🇿🇲")
        case .ZW: return Region(id: 57000260,
                              key: "ZW",
                              name: "Zimbabwe",
                              isCountry: true,
                              emoji: "🇿🇼")
        }
    }
}
