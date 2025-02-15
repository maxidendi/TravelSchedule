import SwiftUI

struct RoutesListView: View {
    
    //MARK: - Properties
    
    @Binding var path: [Paths]
    @StateObject private var routesListViewModel = RoutesListViewModel()
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    
    //MARK: - Body

    var body: some View {
        ZStack(alignment: .leading) {
            switch routesListViewModel.state {
            case .loading:
                VStack(alignment: .leading) {
                    titleView
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
                    titleView
                    routesListView
                }
                .ignoresSafeArea(.all, edges: .bottom)
                .padding([.horizontal, .top])
                stubAndButtonView
            case .error(let error):
                Spacer()
                ErrorView(errorType: error)
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .task {
            await routesListViewModel.getRoutes(
                from: scheduleViewModel.stationFromCode,
                to: scheduleViewModel.stationToCode)
        }
    }
    
    //MARK: - Subviews
    
    private var titleView: some View {
        Text("\(scheduleViewModel.fromText) → \(scheduleViewModel.toText)")
            .padding(.leading, .zero)
            .padding(.bottom, 16)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
            .font(.system(size: 24, weight: .bold))
    }
    
    private var routesListView: some View {
        ScrollView(.vertical) {
            ForEach(routesListViewModel.getFilteredCarrierList()) { route in
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
    
    private var stubAndButtonView: some View {
        VStack {
            Spacer()
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .opacity(routesListViewModel.getFilteredCarrierList().isEmpty ? 1 : 0)
            Spacer()
            NavigationLink {
                FiltersView(routesViewModel: routesListViewModel)
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
                        if !routesListViewModel.departureFilters.isEmpty ||
                            routesListViewModel.isTransferredFilter != nil {
                            Circle()
                                .fill(.ypRed)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    RoutesListView(path: .constant([]))
        .environmentObject(ScheduleViewModel())
}
