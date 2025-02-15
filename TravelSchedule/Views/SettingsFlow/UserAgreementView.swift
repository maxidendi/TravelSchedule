import SwiftUI

struct UserAgreementView: View {
    
    //MARK: - Properties
    
    let urlString: String
    
    //MARK: - Body
    
    var body: some View {
        AgreementWebView(urlString: urlString)
            .toolbar(.hidden, for: .tabBar)
            .toolbarRole(.editor)
            .navigationTitle("Пользовательское соглашение")
            .background(.ypWhite)
    }
}

#Preview {
    UserAgreementView(urlString: Constants.API.agreementURLString)
}
