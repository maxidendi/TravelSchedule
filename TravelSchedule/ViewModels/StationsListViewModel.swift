import Foundation

@MainActor
final class StationsListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var searchText: String = ""
    @Published private(set) var city: City = City(title: "", stations: [])
    
    //MARK: - Methods
    
    func filteredStations() -> [Station] {
        return searchText.isEmpty ? city.stations : city.stations.filter{ $0.title.localizedCaseInsensitiveContains(searchText)}
    }
    
    func setupCity(_ city: City) {
        self.city = city
    }
}

