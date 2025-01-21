import Foundation

final class SearchStore: ObservableObject {
    
    //MARK: - Properties
    
    @Published var cityFrom: String = ""
    @Published var cityTo: String = ""
    @Published var stationsFrom: String = ""
    @Published var stationsTo: String = ""
    @Published var stationFromCode: String = ""
    @Published var stationToCode: String = ""
    @Published var fromText: String = ""
    @Published var toText: String = ""
    
    //MARK: - Methods
    
    func setupfromText() {
        fromText = "\(cityFrom) (\(stationsFrom))"
    }
    
    func setupToText() {
        toText = "\(cityTo) (\(stationsTo))"
    }
    
    func resetDirections() {
        swap(&stationFromCode, &stationToCode)
        swap(&fromText, &toText)
    }
}
