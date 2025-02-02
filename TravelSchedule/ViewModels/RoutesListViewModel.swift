import Foundation
import OpenAPIURLSession

@MainActor
final class RoutesListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var routes: [Route] = []
    @Published private(set) var stateMachine = LoadStateMachine()
    @Published private(set) var departureFilters: Set<DepartureTimes> = []
    @Published private(set) var isTransferedFilter: Bool? = nil
    
    private let networkClient = NetworkClient.shared
    
    //MARK: - Methods
    
    func getFilteredCarrierList() -> [Route] {
        if departureFilters.isEmpty {
            return isTransferedFilter != nil ? routes.filter { $0.isTransfered == isTransferedFilter } : routes
        } else {
            return isTransferedFilter != nil ?
            routes.filter { $0.isTransfered == isTransferedFilter && departureFilters.contains($0.dayTime) } :
            routes.filter { departureFilters.contains($0.dayTime) }
        }
    }
    
    func setFilters(_ departureFilters: Set<DepartureTimes>, _ transferFilter: Bool?) {
        self.departureFilters = departureFilters
        isTransferedFilter = transferFilter
    }
    
    func getRoutes(from: String, to: String) async {
        stateMachine.state = .loading
        routes.removeAll()
        do {
            let routes = try await networkClient.fetchRoutes(from: from, to: to)
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
