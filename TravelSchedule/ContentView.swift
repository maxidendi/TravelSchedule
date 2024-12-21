import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    //MARK: - Properties
    
    private let apikey = Constants.API.yandexScheduleAPIKey
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            let client = Client(
                serverURL: try! Servers.Server1.url(),
                transport: URLSessionTransport())
            do {
                try await nearestStations(client: client)
                try await routesWithDestination(client: client)
                try await routesFrom(client: client)
                try await threadStationsList(client: client)
                try await nearestSettlement(client: client)
                try await carrier(client: client)
                try await stationsList(client: client)
                try await copyright(client: client)
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Methods
    
    private func nearestStations(client: Client) async throws {
        let nearestStationsService = NearestStationsService(
            client: client,
            apikey: apikey)
        let response = try await nearestStationsService.getNearestStations(
            lat: 54.74306,
            lng: 55.96779,
            distance: 2)
        print("Nearest stations:\n\n \(response)\n")
    }
    
    private func routesWithDestination(client: Client) async throws {
        let routesWithDestination = RoutesWithDestinationService(
            client: client,
            apikey: apikey)
        let response = try await routesWithDestination.getRoutesWithDestination(
            from: "c146",
            to: "c213",
            date: "2024-12-13")
        print("Routes with destination:\n\n \(response)\n")
    }

    private func routesFrom(client: Client) async throws {
        let routesFromService = RoutesFromService(
            client: client,
            apikey: apikey)
        let response = try await routesFromService.getRoutesFrom(
            station: "s9606364",
            date: "2024-12-30")
        print("Routes from:\n\n \(response)\n")
    }
    
    private func threadStationsList(client: Client) async throws {
        let threadStationsList = ThreadStationsService(
            client: client,
            apikey: apikey)
        let response = try await threadStationsList.getThreadStationsList(
            uid: "391U_2_2")
        print("Threads stations:\n\n \(response)\n")
    }
    
    private func nearestSettlement(client: Client) async throws {
        let nearestSettlementService = NearestSettlementService(
            client: client,
            apikey: apikey)
        let response = try await nearestSettlementService.getNearestSettlement(
            lat: 54.74306,
            lng: 55.96779)
        print("Nearest settlement:\n\n \(response)\n")
    }

    private func carrier(client: Client) async throws {
        let carrierService = CarrierService(
            client: client,
            apikey: apikey)
        let response = try await carrierService.getCarrierDescription(code: "8565")
        print("Carrier:\n\n \(response)\n")
    }
    
    private func stationsList(client: Client) async throws {
        let stationsListService = StationsListService(
            client: client,
            apikey: apikey)
        let response = try await stationsListService.getStationsList()
        print("Some stations:\n\n \(String(describing: response.countries?[135]))\n")
    }
    
    private func copyright(client: Client) async throws {
        let copyrightService = CopyrightService(
            client: client,
            apikey: apikey)
        let response = try await copyrightService.getCopyright()
        print("Copyright:\n\n \(response)\n")
    }
}

#Preview {
    ContentView()
}
