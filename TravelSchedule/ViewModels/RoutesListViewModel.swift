import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

@MainActor
final class RoutesListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var routes: [Route] = []
    @Published private(set) var state: LoadState = .loading
    @Published private(set) var departureFilters: Set<DepartureTimes> = []
    @Published private(set) var isTransferredFilter: Bool? = nil
    
    private let networkClient = NetworkClient.shared
    
    //MARK: - Methods
    
    func getFilteredCarrierList() -> [Route] {
        if departureFilters.isEmpty {
            return isTransferredFilter != nil ? routes.filter { $0.isTransferred == isTransferredFilter } : routes
        } else {
            return isTransferredFilter != nil ?
            routes.filter { $0.isTransferred == isTransferredFilter && departureFilters.contains($0.dayTime) } :
            routes.filter { departureFilters.contains($0.dayTime) }
        }
    }
    
    func setFilters(_ departureFilters: Set<DepartureTimes>, _ transferFilter: Bool?) {
        self.departureFilters = departureFilters
        isTransferredFilter = transferFilter
    }
    
    func getRoutes(from: String, to: String) async {
        state = .loading
        routes.removeAll()
        do {
            let routes = try await networkClient.fetchRoutes(from: from, to: to)
            routes.segments?.forEach{ segment in getRoute(from: segment) }
            state = .loaded
        } catch {
            if let error = error as? ClientError,
               let code = error.response?.status.code {
                switch code {
                case 400..<500:
                    state = .error(.badRequest)
                case 500..<600:
                    state = .error(.serverError)
                default:
                    state = .error(.badRequest)
                }
            } else {
                switch error._code {
                case NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet:
                    state = .error(.noInternet)
                default:
                    state = .error(.noInternet)
                }
            }
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
            isTransferred: segment.has_transfers ?? false)
        routes.append(route)
    }
}
