import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers

protocol CarrierServiceProtocol {
    func getCarrierDescription(code: String) async throws -> Carriers
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierDescription(code: String) async throws -> Carriers {
        let response = try await client.getCarrierDescription(query: .init(
            apikey: apikey,
            code: code))
        return try response.ok.body.json
    }
}
