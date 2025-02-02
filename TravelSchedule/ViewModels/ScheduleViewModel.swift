import Foundation

@MainActor
final class ScheduleViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var stationFromCode: String = ""
    @Published private(set) var stationToCode: String = ""
    @Published private(set) var fromText: String = ""
    @Published private(set) var toText: String = ""
    
    //MARK: - Methods
    
    func setupCityAndStation(_ city: String, _ station: String, direction: Directions) {
        switch direction {
        case .from:
            fromText = "\(city) (\(station))"
        case .to:
            toText = "\(city) (\(station))"
        }
    }
    
    func setupStationCodes(_ code: String, _ direction: Directions) {
        switch direction {
        case .from:
            stationFromCode = code
        case .to:
            stationToCode = code
        }
    }
    
    func resetDirections() {
        swap(&stationFromCode, &stationToCode)
        swap(&fromText, &toText)
    }
}
