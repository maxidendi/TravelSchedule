import Foundation

struct Route: Identifiable {
    
    //MARK: - Init
    
    init(
        id: UUID = UUID(),
        carrier: Carrier,
        transfer: String,
        departureDate: String,
        arrivalDate: String,
        isTransfered: Bool
    ) {
        self.id = id
        self.carrier = carrier
        self.transfer = transfer
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.dayTime = DepartureTimes.from(date: Route.isoDateFormatted.date(from: departureDate))
        self.isTransfered = isTransfered
    }
    
    //MARK: - Properties

    let id: UUID
    let carrier: Carrier
    let transfer: String
    let departureDate: String
    let arrivalDate: String
    let dayTime: DepartureTimes
    var isTransfered: Bool
    
    static nonisolated(unsafe) private let isoDateFormatted = ISO8601DateFormatter()
    static private let dateFormatter = DateFormatter()
    
    var formattedDepartureDate: String? {
        guard let date = Route.isoDateFormatted.date(from: departureDate) else { return nil }
        Route.dateFormatter.locale = Locale(identifier: "ru_RU")
        Route.dateFormatter.dateFormat = "d MMMM"
        return Route.dateFormatter.string(from: date)
    }
    var formattedDepartureTime: String? {
        guard let date = Route.isoDateFormatted.date(from: departureDate) else { return nil }
        Route.dateFormatter.locale = Locale(identifier: "ru_RU")
        Route.dateFormatter.timeStyle = .short
        return Route.dateFormatter.string(from: date)
    }
    var formattedArrivalTime: String? {
        guard let date = Route.isoDateFormatted.date(from: arrivalDate) else { return nil }
        Route.dateFormatter.locale = Locale(identifier: "ru_RU")
        Route.dateFormatter.timeStyle = .short
        return Route.dateFormatter.string(from: date)
    }
    var hourage: String? {
        guard let departureDate = Route.isoDateFormatted.date(from: departureDate),
              let arrivalDate = Route.isoDateFormatted.date(from: arrivalDate)
        else { return nil }
        let hours = Int(arrivalDate.timeIntervalSince(departureDate) / 3600)
        return "\(hours) часов"
    }
}
