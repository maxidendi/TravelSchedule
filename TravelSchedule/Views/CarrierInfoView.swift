import SwiftUI

struct CarrierInfoView: View {
    
    //MARK: - Properties
    
    let carrier: Carrier
    @EnvironmentObject var router: Router
    
    //MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(carrier.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 104)
            Text(carrier.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("E-Mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlack)
                    Text(carrier.email)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypBlue)
                }
                .padding(.vertical, 12)
                VStack(alignment: .leading) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlack)
                    Text(carrier.phone)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypBlue)
                }
                .padding(.vertical, 12)
            }
        }
        .padding()
        Spacer()
    }
}

#Preview {
    CarrierInfoView(carrier: Carrier(
        logo: .fgkLogo,
        shortTitle: "FGK",
        title: "OAO \"FGK\"",
        email: "fgk@fgk.ru",
        phone: "+7 499 999 999"))
}
