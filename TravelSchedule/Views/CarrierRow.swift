import SwiftUI

struct CarrierRow: View {
    
    //MARK: - Properties
    
    let route: Route
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.ypLightGrayUniversal)
            VStack {
                HStack {
                    AsyncImage(url: URL(string: route.carrier.logo)) { phase in
                        switch phase {
                        case .empty:
                            Image(.logoIconStub)
                                .scaledToFit()
                                .frame(maxWidth: 38, maxHeight: 38)
                                .padding(.trailing, 8)
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(maxWidth: 38, maxHeight: 38)
                                .padding(.trailing, 8)
                        case .failure(_):
                            Image(.logoIconStub)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    if route.isTransfered {
                        VStack(alignment: .leading) {
                            Text(route.carrier.title)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.ypBlackUniversal)
                            Text(route.transfer)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.ypRed)
                        }
                    } else {
                        Text(route.carrier.title)
                            .font(.system(size: 17, weight: .regular))
                            .tint(.ypBlackUniversal)
                    }
                    Spacer()
                    VStack {
                        Text(route.formattedDepartureDate ?? "")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.ypBlackUniversal)
                        Spacer()
                    }
                }
                Spacer()
                HStack(spacing: 5) {
                    Text(route.formattedDepartureTime ?? "")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlackUniversal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.ypGray)
                    Text(route.hourage ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypBlackUniversal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.ypGray)
                    Text(route.formattedArrivalTime ?? "")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlackUniversal)
                }
            }
            .padding(14)
        }
        .frame(height: 104)
    }
}

#Preview {
    CarrierRow(route: Route(carrier:
                                Carrier(logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
                                        title: "ОАО \"РЖД\"",
                                        email: "i.lozgkina@yandex.ru",
                                        phone: "+7 (904) 329-27-71"),
                              transfer: "С пересадкой в Костроме",
                              departureDate: "2025-01-14T22:30:00+05:00",
                            arrivalDate: "2025-01-15T08:15:00+05:00",
                            isTransfered: false))
}
