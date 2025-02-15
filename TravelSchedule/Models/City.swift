import Foundation

struct City: Identifiable, Hashable, Sendable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
