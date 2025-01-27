import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias RoutesWithDestination = Components.Schemas.RoutesWithDestination

protocol RoutesWithDestinationServiceProtocol {
    func getRoutesWithDestination(from: String, to: String) async throws -> RoutesWithDestination
}

final class RoutesWithDestinationService: RoutesWithDestinationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesWithDestination(from: String, to: String) async throws -> RoutesWithDestination {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        let response = try await client.getRoutesWithDestination(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            transfers: true,
            date: date))
        return try response.ok.body.json
    }
}
