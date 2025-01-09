import SwiftUI

struct CarriersListView: View {
    
    //MARK: - Properties
    
    private let mockCarriersList: [Route] = [
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
              departureDate: "2025-01-16T12:30:00+05:00",
              arrivalDate: "2025-01-16T21:00:00+05:00")
    ]
    @EnvironmentObject var store: SearchStore
    @EnvironmentObject var router: Router
    
    //MARK: - Body

    var body: some View {
        ZStack {
            VStack {
                Text("\(store.fromText) → \(store.toText)")
                    .padding(.init(top: 0, leading: 0, bottom: 16, trailing: 0))
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 24, weight: .bold))
                List(mockCarriersList) { route in
                    CarrierRow(route: route)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
                        .onTapGesture { [route] in
                            router.push(.carrierDetails(route.carrier))
                        }
                }
                .listStyle(.inset)
            }
            .padding(16)
            VStack {
                Spacer()
                Button(
                    action: { router.push(.filters) },
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .padding(.horizontal, 16)
                                .frame(height: 60)
                                .foregroundColor(.ypBlue)
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.ypWhiteUniversal)
                        }
                    })
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    CarriersListView()
        .environmentObject(SearchStore())
        .environmentObject(Router.shared)
}
