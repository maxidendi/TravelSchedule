import Foundation

struct City: Identifiable {
    let id = UUID()
    let cityName: String
    let stations: [Station]
}
