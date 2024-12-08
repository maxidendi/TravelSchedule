import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    //MARK: - Properties
    
    let apikey = "092a8be2-0a60-47f7-a961-925ec208e58a"
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            nearestStations()
//            routesWithDestination()
//            routesFrom()
//            threadStationsList()
            nearestSettlement()
        }
    }
    
    //MARK: - Methods
    
    func nearestStations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let nearestStationsService = NearestStationsService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await nearestStationsService.getNearestStations(
                    lat: 54.74306,
                    lng: 55.96779,
                    distance: 2)
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func routesWithDestination() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let routesWithDestination = RoutesWithDestinationService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await routesWithDestination.getRoutesWithDestination(
                    from: "c146",
                    to: "c213",
                    date: "2024-12-13")
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func routesFrom() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let routesFromService = RoutesFromService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await routesFromService.getRoutesFrom(
                    station: "s9606364",
                    date: "2024-12-09")
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func threadStationsList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let threadStationsList = ThreadStationsService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await threadStationsList.getThreadStationsList(
                    uid: "391U_2_2",
                    date: "2024-12-09")
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func nearestSettlement() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let nearestSettlementService = NearestSettlementService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await nearestSettlementService.getNearestSettlement(
                    lat: 54.74306,
                    lng: 55.96779)
                print(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

#Preview {
    ContentView()
}
