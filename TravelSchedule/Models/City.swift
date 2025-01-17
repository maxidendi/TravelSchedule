import Foundation

struct City: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
