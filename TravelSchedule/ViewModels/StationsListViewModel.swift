import Foundation

@MainActor
final class StationsListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var searchText: String = ""
    private var city: City
    
    //MARK: - Init
    
    init(city: City) {
        self.city = city
    }
    
    //MARK: - Methods
    
    func filteredStations() -> [Station] {
        searchText.isEmpty ? city.stations : city.stations.filter{ $0.title.localizedCaseInsensitiveContains(searchText)}
    }
}

