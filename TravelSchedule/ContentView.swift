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
        .onAppear {
            nearestStations()
            routesWithDestination()
            routesFrom()
            threadStationsList()
            nearestSettlement()
            carrier()
            stationsList()
            copyright()
        }
    }
    
    //MARK: - Methods
    
    //Принты добавил что бы быстро посмотреть в логе, что все данные поступают и парсятся
    //Обязательно их уберу после ревью))
    
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
                print("Nearest stations:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
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
                print("Routes with destination:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
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
                    date: "2024-12-30")
                print("Routes from:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
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
                    uid: "391U_2_2")
                print("Threads stations:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
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
                print("Nearest settlement:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }

    func carrier() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let carrierService = CarrierService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await carrierService.getCarrierDescription(code: "8565")
                print("Carrier:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func stationsList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let stationsListService = StationsListService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await stationsListService.getStationsList()
                print("Some stations:\n\n \(String(describing: response.countries?[135]))\n")
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    func copyright() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let copyrightService = CopyrightService(
            client: client,
            apikey: apikey)
        Task {
            do {
                let response = try await copyrightService.getCopyright()
                print("Copyright:\n\n \(response)\n")
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
