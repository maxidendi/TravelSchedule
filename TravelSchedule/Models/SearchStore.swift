import Foundation

final class SearchStore: ObservableObject {
    
    //MARK: - Properties
    
    @Published var cityFrom: String = ""
    @Published var cityTo: String = ""
    @Published var stationsFrom: String = ""
    @Published var stationsTo: String = ""
    @Published var fromText: String = ""
    @Published var toText: String = ""
    @Published var departureFilters: Set<DepartureTimes> = []
    @Published var isTransfered: Transfer = .none
    
    //MARK: - Methods
    
    func setupfromText() {
        fromText = "\(cityFrom) (\(stationsFrom))"
    }
    
    func setupToText() {
        toText = "\(cityTo) (\(stationsTo))"
    }
    
    func resetDirections() {
        let temporaryText = fromText
        fromText = toText
        toText = temporaryText
    }
}
