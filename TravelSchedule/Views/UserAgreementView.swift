import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        AgreementWebView(urlString: Constants.API.agreementURLString)
    }
}

#Preview {
    UserAgreementView()
}
