import SwiftUI

struct ErrorView: View {
    
    @State var errorType: ErrorType
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            switch errorType {
            case .noInternet:
                Image(.stubNoInternet)
                    .resizable()
                    .frame(width: 223, height: 223)
                    .scaledToFit()
                Text(errorType.rawValue)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
            case .serverError:
                Image(.stubServerError)
                    .resizable()
                    .frame(width: 223, height: 223)
                    .scaledToFit()
                Text(errorType.rawValue)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
            }
        }
    }
}

#Preview {
    ErrorView(errorType: .noInternet)
}
