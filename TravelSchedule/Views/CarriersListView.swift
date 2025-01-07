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
              arrivalDate: "2025-01-16T21:00:00+05:00")
    ]
    @EnvironmentObject var store: SearchStore
    @EnvironmentObject var router: Router
    
    //MARK: - Body

    var body: some View {
        VStack {
            Text("\(store.fromText) → \(store.toText)")
                .multilineTextAlignment(.leading)
                .font(.system(size: 24, weight: .bold))
            List(mockCarriersList) {
                CarrierRow(route: $0)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
            .listStyle(.inset)
        }
        .padding(16)
    }
}

#Preview {
    CarriersListView()
        .environmentObject(SearchStore())
}
