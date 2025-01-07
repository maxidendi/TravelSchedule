import Foundation

struct Route: Identifiable {
    var id = UUID()
    let carrier: Carrier
    let transfer: String?
    let departureDate: String
    let arrivalDate: String
    
    private let isoDateFormatted = ISO8601DateFormatter()
    private let dateFormatter = DateFormatter()
    var formattedDepartureDate: String? {
        guard let date = isoDateFormatted.date(from: departureDate) else { return nil }
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: date)
    }
    var formattedDepartureTime: String? {
        guard let date = isoDateFormatted.date(from: departureDate) else { return nil }
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    var formattedArrivalTime: String? {
        guard let date = isoDateFormatted.date(from: arrivalDate) else { return nil }
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    var hourage: String? {
        guard let departureDate = isoDateFormatted.date(from: departureDate),
              let arrivalDate = isoDateFormatted.date(from: arrivalDate)
        else { return nil }
        let hours = Int(arrivalDate.timeIntervalSince(departureDate) / 3600)
        return "\(hours) часов"
    }
}
