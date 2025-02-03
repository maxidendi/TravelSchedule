import Foundation
import OpenAPIURLSession

actor NetworkClient {
    
    //MARK: - Properties
    
    private var cachedStationsList: StationsList?
    private var cachedRoutesList: RoutesWithDestination?
    private var currentDestinationCodes: (String, String)?
    private let client: Client
    private let apiKey: String
    private var citiesDownloadTask: Task<StationsList, Error>?
    private var routesDownloadTask: Task<RoutesWithDestination, Error>?
    
    static let shared = NetworkClient()
    
    //MARK: - Init
    
    init(apiKey: String = Constants.API.yandexScheduleAPIKey) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        let transport = URLSessionTransport(configuration: .init(session: .init(configuration: config)))
        self.client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: transport)
        self.apiKey = apiKey
    }
    
    //MARK: - Methods
    
    func fetchCities() async throws -> StationsList {
        if let cachedStationsList {
            return cachedStationsList
        }
        if let citiesDownloadTask {
            return try await citiesDownloadTask.value
        }
        let service = StationsListService(
            client: client,
            apikey: Constants.API.yandexScheduleAPIKey)
        let stationsList = try await service.getStationsList()
        cachedStationsList = stationsList
        citiesDownloadTask = nil
        return stationsList
    }
    
    func fetchRoutes(from fromCode: String, to toCode: String) async throws -> RoutesWithDestination {
        if let cachedRoutesList,
            let currentDestinationCodes,
            currentDestinationCodes == (fromCode, toCode)
        {
            return cachedRoutesList
        }
        if let routesDownloadTask {
            return try await routesDownloadTask.value
        }
        let service = RoutesWithDestinationService(
            client: client,
            apikey: Constants.API.yandexScheduleAPIKey)
        let routesWithDestination = try await service.getRoutesWithDestination(from: fromCode, to: toCode)
        cachedRoutesList = routesWithDestination
        currentDestinationCodes = (fromCode, toCode)
        routesDownloadTask = nil
        return routesWithDestination
    }
}
