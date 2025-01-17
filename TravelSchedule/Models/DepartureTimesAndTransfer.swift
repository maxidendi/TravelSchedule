import Foundation

enum DepartureTimes: String, Hashable {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    case none
    
    static func from(date: Date?) -> DepartureTimes {
        guard let date else { return none }
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 0...5: return .night
        case 6...11: return .morning
        case 12...17: return .afternoon
        case 18...23: return .evening
        default:
            return none
        }
    }
}

enum Transfer: String, Hashable {
    case yes = "Да"
    case no = "Нет"
    case none
}
