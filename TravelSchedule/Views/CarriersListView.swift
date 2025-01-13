import SwiftUI

struct CarriersListView: View {
    
    //MARK: - Properties
    
    @EnvironmentObject var store: SearchStore
    @EnvironmentObject var router: Router
    @State var departureFilters: Set<DepartureTimes> = []
    @State var isTransfered: Bool? = nil
    private var filteredCarriersList: [Route] {
        if departureFilters.isEmpty {
            if let isTransfered {
                return CarriersListView.mockCarriersList.filter {
                    $0.isTransfered == isTransfered
                }
            } else {
                return CarriersListView.mockCarriersList
            }
        } else {
            if let isTransfered {
                return CarriersListView.mockCarriersList.filter {
                    $0.isTransfered == isTransfered && departureFilters.contains($0.dayTime)
                }
            } else {
                return CarriersListView.mockCarriersList.filter {
                    departureFilters.contains($0.dayTime)
                }
            }
        }
    }
    
    //MARK: - Body

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(store.fromText) → \(store.toText)")
                    .padding(.leading, .zero)
                    .padding(.bottom, 16)
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
                .scrollIndicators(.hidden)
            }
            .padding(16)
            VStack {
                Spacer()
                NavigationLink {
                    FiltersView(departureFilters: $departureFilters,
                                isTransfered: $isTransfered)
                    .navigationTitle("")
                    .toolbarRole(.editor)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .padding(.horizontal, 16)
                            .frame(height: 60)
                            .foregroundColor(.ypBlue)
                        Text("Уточнить время")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.ypWhiteUniversal)
                    }
                }
                .padding(.bottom, 24)
            }
        }
    }
}

extension CarriersListView {
    static let mockCarriersList: [Route] = [
        Route(carrier:
                Carrier(logo: .rzhdLogo,
                        shortTitle: "РЖД",
                        title: "ОАО \"РЖД\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (904) 329-27-71"),
              transfer: "С пересадкой в Костроме",
              departureDate: "2025-01-14T22:30:00+05:00",
              arrivalDate: "2025-01-15T08:15:00+05:00"),
        Route(carrier:
                Carrier(logo: .fgkLogo,
                        shortTitle: "ФГК",
                        title: "ОАО \"ФГК\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (987) 329-27-77"),
              transfer: nil,
              departureDate: "2025-01-15T01:15:00+05:00",
              arrivalDate: "2025-01-15T09:00:00+05:00"),
        Route(carrier:
                Carrier(logo: .uralLogo,
                        shortTitle: "Урал логистика",
                        title: "ОАО \"Урал логистика\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (987) 329-27-88"),
              transfer: nil,
              departureDate: "2025-01-16T12:30:00+05:00",
              arrivalDate: "2025-01-16T21:00:00+05:00"),
        Route(carrier:
                Carrier(logo: .rzhdLogo,
                        shortTitle: "RZHD",
                        title: "ОАО \"RZHD\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (904) 329-27-71"),
              transfer: "С пересадкой в Костроме",
              departureDate: "2025-01-14T22:30:00+05:00",
              arrivalDate: "2025-01-15T08:15:00+05:00"),
        Route(carrier:
                Carrier(logo: .fgkLogo,
                        shortTitle: "FGK",
                        title: "ОАО \"FGK\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (987) 329-27-77"),
              transfer: "Through Kostroma",
              departureDate: "2025-01-14T12:15:00+05:00",
              arrivalDate: "2025-01-15T09:00:00+05:00"),
        Route(carrier:
                Carrier(logo: .uralLogo,
                        shortTitle: "Урал логистика",
                        title: "ОАО \"Урал логистика\"",
                        email: "i.lozgkina@yandex.ru",
                        phone: "+7 (987) 329-27-88"),
              transfer: nil,
              departureDate: "2025-01-16T08:30:00+05:00",
              arrivalDate: "2025-01-16T21:00:00+05:00")
    ]
}

#Preview {
    CarriersListView()
        .environmentObject(SearchStore())
}
