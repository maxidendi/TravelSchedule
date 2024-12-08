import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStationsList = Components.Schemas.ThreadStationsList

protocol ThreadStationsServiceProtocol {
    func getThreadStationsList(uid: String, date: String?) async throws -> ThreadStationsList
}

final class ThreadStationsService: ThreadStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStationsList(uid: String, date: String?) async throws -> ThreadStationsList {
        let response = try await client.getThreadStationsList(query: .init(
            apikey: apikey,
            uid: uid,
            date: date))
        return try response.ok.body.json
    }
}
