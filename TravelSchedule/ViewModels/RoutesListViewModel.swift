import Foundation
import OpenAPIURLSession

@MainActor
final class RoutesListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var routes: [Route] = []
    @Published var stateMachine = LoadStateMachine()
    
    //MARK: - Methods
    
    func getRoutes(from: String, to: String) async {
        routes.removeAll()
        stateMachine.state = .loading
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport())
        let service = RoutesWithDestinationService(
            client: client,
            apikey: Constants.API.yandexScheduleAPIKey)
        do {
            let routes = try await service.getRoutesWithDestination(from: from, to: to)
            routes.segments?.forEach{ segment in getRoute(from: segment) }
            stateMachine.state = .loaded
        } catch {
            stateMachine.state = .error(.noInternet)
        }
    }
    
    private func getRoute(from segment: Components.Schemas.Segment) {
        guard let carrierComponent = segment.thread?.carrier else { return }
        let carrier = Carrier(
            logo: carrierComponent.logo ?? "",
            title: carrierComponent.title ?? "",
            email: carrierComponent.email ?? "",
            phone: carrierComponent.phone ?? "")
        let route: Route = Route(
            carrier: carrier,
            transfer: segment.stops ?? "",
            departureDate: segment.departure ?? "",
            arrivalDate: segment.arrival ?? "",
            isTransfered: segment.has_transfers ?? false)
        routes.append(route)
    }
}
