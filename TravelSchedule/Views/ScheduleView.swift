import SwiftUI

enum Paths: Hashable {
    case citiesList(Directions)
    case stationsList(Directions)
    case carriersList
    case filters
    case carrierDetails
}

enum Directions {
    case from
    case to
}

struct ScheduleView: View {
    
    //MARK: - Properties

    @StateObject var store = SearchStore()
    @ObservedObject var router = Router.shared

    //MARK: - Body

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 16) {
                HStack {
                    VStack {
                        TextField("Откуда", text: $store.fromText)
                            .font(.system(size: 17))
                            .frame(height: 48)
                            .padding(.leading, 16)
                            .simultaneousGesture(TapGesture().onEnded {
                                router.push(.citiesList(.from))
                            })
                        TextField("Куда", text: $store.toText)
                            .font(.system(size: 17))
                            .frame(height: 48)
                            .padding(.leading, 16)
                            .simultaneousGesture(TapGesture().onEnded {
                                router.push(.citiesList(.to))
                            })
                    }
                    .background(Color.white.cornerRadius(20))
                    .padding(.all, 16)
                    Button(action: store.resetDirections) {
                        Image(.changeScheduleIcon)
                            .renderingMode(.template)
                            .accentColor(.ypBlue)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color.white))
                            .padding(.trailing, 16)
                    }
                }
                .background(Color.ypBlue.cornerRadius(20))
                .padding(.horizontal, 16)
                .padding(.top, 208)
                if !store.fromText.isEmpty && !store.toText.isEmpty {
                    Button(
                        action: { router.push(.carriersList) },
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 150, height: 60)
                                Text("Найти")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.white)
                            }
                        })
                }
                Spacer()
                Divider()
            }
            .navigationTitle("")
            .navigationDestination(for: Paths.self) { path in
                switch path {
                case .citiesList(let direction):
                    CitiesListView(direction: direction)
                        .navigationTitle("Выбор города")
                        .environmentObject(router)
                        .environmentObject(store)
                        .toolbar(.hidden, for: .tabBar)
                        .toolbarRole(.editor)
                case .stationsList(let direction):
                    StationsListView(direction: direction)
                        .navigationTitle("Выбор станции")
                        .environmentObject(router)
                        .environmentObject(store)
                        .toolbar(.hidden, for: .tabBar)
                        .toolbarRole(.editor)
                case .carriersList:
                    CarriersListView()
                        .environmentObject(router)
                        .toolbar(.hidden, for: .tabBar)
                        .toolbarRole(.editor)
                case .filters:
                    Text("Filters")
                case .carrierDetails:
                    Text("Carriers details")
                }
            }
        }
    }
}

#Preview {
    ScheduleView()
}
