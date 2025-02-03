import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

@MainActor
final class CitiesListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var cities: [City] = []
    @Published var state : LoadState = .loading 
    @Published var searchText: String = ""

    private let networkClient = NetworkClient.shared
    
    //MARK: - Methods
    
    func filteredCities() -> [City] {
        searchText.isEmpty ? cities : cities.filter { $0.title.lowercased().contains(searchText.lowercased())}
    }
    
    func getCities() async {
        state = .loading
        cities.removeAll()
        do {
            let stations = try await networkClient.fetchCities()
            parseResult(stations)
        } catch {
            if let error = error as? ClientError,
               let code = error.response?.status.code {
                switch code {
                case 400..<500:
                    state = .error(.badRequest)
                case 500..<600:
                    state = .error(.serverError)
                default:
                    state = .error(.badRequest)
                }
            } else if let error = error as? ClientError {
                state = error.causeDescription == "The request timed out." ? .error(.noInternet) : .error(.badRequest)
            } else {
                switch error._code {
                case NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet:
                    state = .error(.noInternet)
                default:
                    state = .error(.badRequest)
                }
            }
        }
    }
    
    private func parseResult(_ stations: StationsList) {
        stations.countries?
            .filter { $0.title == "Россия" }
            .forEach { country in country.regions?.forEach { region in getSettlements(region) }}
        cities.sort { $0.title < $1.title }
        state = .loaded
    }
    
    private func getSettlements(_ region: Components.Schemas.Region) {
        region.settlements?.forEach { settlement in
            if let title = settlement.title,
               title != "" {
                var stations: [Station] = []
                getStations(settlement, &stations)
                if !stations.isEmpty {
                    let city = City(title: title, stations: stations.sorted { $0.title < $1.title })
                    cities.append(city)
                }
            }
        }
    }
    
    private func getStations(_ settlement: Components.Schemas.Settlement, _ stations: inout [Station]) {
        settlement.stations?.forEach { station in
            if station.transport_type == "train",
               let stationName = station.title,
               stationName != "",
               let code = station.codes?.yandex_code {
                stations.append(Station(title: stationName, code: code))
            }
        }
    }
}
