import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        AgreementWebView(urlString: Constants.API.agreementURLString)
            .toolbar(.hidden, for: .tabBar)
            .toolbarRole(.editor)
            .navigationTitle("Пользовательское соглашение")
            .background(.ypWhite)
    }
}

#Preview {
    UserAgreementView()
}
