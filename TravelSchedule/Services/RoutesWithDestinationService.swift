import OpenAPIRuntime
import OpenAPIURLSession

typealias RoutesWithDestination = Components.Schemas.RoutesWithDestination

protocol RoutesWithDestinationServiceProtocol {
    func getRoutesWithDestination(from: String, to: String, date: String?) async throws -> RoutesWithDestination
}

final class RoutesWithDestinationService: RoutesWithDestinationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesWithDestination(from: String, to: String, date: String?) async throws -> RoutesWithDestination {
        let response = try await client.getRoutesWithDestination(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date))
        return try response.ok.body.json
    }
}
