import SwiftUI

@MainActor
struct RoutesListView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject var store: SearchStore
    @EnvironmentObject var router: Router
    @State private var departureFilters: Set<DepartureTimes> = []
    @State private var isTransferedFilter: Bool? = nil
    @StateObject private var routesListViewModel = RoutesListViewModel()
    private var filteredCarriersList: [Route] {
        if departureFilters.isEmpty {
            if let isTransferedFilter {
                return routesListViewModel.routes.filter {
                    $0.isTransfered == isTransferedFilter
                }
            } else {
                return routesListViewModel.routes
            }
        } else {
            if let isTransferedFilter {
                return routesListViewModel.routes.filter {
                    $0.isTransfered == isTransferedFilter && departureFilters.contains($0.dayTime)
                }
            } else {
                return routesListViewModel.routes.filter {
                    departureFilters.contains($0.dayTime)
                }
            }
        }
    }
    
    //MARK: - Body

    var body: some View {
        ZStack {
            switch routesListViewModel.stateMachine.state {
            case .loading:
                VStack(alignment: .leading) {
                    Text("\(store.fromText) → \(store.toText)")
                        .padding(.leading, .zero)
                        .padding(.bottom, 16)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            case .loaded:
                VStack(alignment: .leading) {
                    Text("\(store.fromText) → \(store.toText)")
                        .padding(.leading, .zero)
                        .padding(.bottom, 16)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 24, weight: .bold))
                    ScrollView(.vertical) {
                        ForEach(filteredCarriersList) { route in
                            NavigationLink {
                                CarrierInfoView(carrier: route.carrier)
                            } label: {
                                CarrierRow(route: route)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        Spacer(minLength: 76)
                    }
                    .ignoresSafeArea()
                    .scrollIndicators(.hidden)
                }
                .padding()
                VStack {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .opacity(filteredCarriersList.isEmpty ? 1 : 0)
                    Spacer()
                    NavigationLink {
                        FiltersView(departureFilters: $departureFilters,
                                    isTransfered: $isTransferedFilter)
                        .navigationTitle("")
                        .toolbarRole(.editor)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .padding(.horizontal, 16)
                                .frame(height: 60)
                                .foregroundColor(.ypBlue)
                            HStack(alignment: .center, spacing: 4) {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.ypWhiteUniversal)
                                if !departureFilters.isEmpty ||
                                    isTransferedFilter != nil {
                                    Circle()
                                        .fill(.ypRed)
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
            case .error(let error):
                ErrorView(errorType: error)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .task {
            if routesListViewModel.routes.isEmpty {
                await routesListViewModel.getRoutes(from: store.stationFromCode, to: store.stationToCode)
            }
        }
    }
}

#Preview {
    RoutesListView()
        .environmentObject(SearchStore())
}
