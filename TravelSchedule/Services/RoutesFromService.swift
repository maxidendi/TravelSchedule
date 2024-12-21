import OpenAPIRuntime
import OpenAPIURLSession

typealias RoutesFrom = Components.Schemas.RoutesFrom

protocol RoutesFromServiceProtocol {
    func getRoutesFrom(station: String, date: String?) async throws -> RoutesFrom
}

final class RoutesFromService: RoutesFromServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesFrom(station: String, date: String?) async throws -> RoutesFrom {
        let response = try await client.getRoutesFrom(query: .init(
            apikey: apikey,
            station: station,
            date: date))
        return try response.ok.body.json
    }
}
