import Foundation
import OpenAPIURLSession

actor NetworkClient {
    
    //MARK: - Properties
    
    private var cachedStationsList: StationsList?
    private var cachedRoutesList: RoutesWithDestination?
    private var currentDestinationCodes: (String, String)?
    private let client: Client
    private let apiKey: String
    
    static let shared = NetworkClient()
    
    //MARK: - Init
    
    init(apiKey: String = Constants.API.yandexScheduleAPIKey) {
        self.client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        self.apiKey = apiKey
    }
    
    //MARK: - Methods
    
    func fetchCities() async throws -> StationsList {
        if let cachedStationsList {
            return cachedStationsList
        }
        let service = StationsListService(
            client: client,
            apikey: Constants.API.yandexScheduleAPIKey)
        let stationsList = try await service.getStationsList()
        cachedStationsList = stationsList
        return stationsList
    }
    
    func fetchRoutes(from fromCode: String, to toCode: String) async throws -> RoutesWithDestination {
        if let cachedRoutesList,
            let currentDestinationCodes,
            currentDestinationCodes == (fromCode, toCode)
        {
            return cachedRoutesList
        }
        let service = RoutesWithDestinationService(
            client: client,
            apikey: Constants.API.yandexScheduleAPIKey)
        let routesWithDestination = try await service.getRoutesWithDestination(from: fromCode, to: toCode)
        cachedRoutesList = routesWithDestination
        currentDestinationCodes = (fromCode, toCode)
        return routesWithDestination
    }
}
