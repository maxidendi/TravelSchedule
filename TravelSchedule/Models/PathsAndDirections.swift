import Foundation

enum Paths: Hashable {
    case citiesList(Directions)
    case stationsList([Station], Directions)
    case carriersList
}

enum Directions {
    case from
    case to
}
