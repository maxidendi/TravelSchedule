import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey))
        let htmlBody = try response.ok.body.html
        let data = try await Data(collecting: htmlBody, upTo: 1024*1024*50)
        return try JSONDecoder().decode(StationsList.self, from: data)
    }
}
