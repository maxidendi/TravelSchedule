import SwiftUI

struct ErrorView: View {
    
    let errorType: ErrorType
    var handler: (() -> Void)?
    
    var body: some View {
        HStack {
            Spacer()
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
                case .badRequest:
                    Image(.stubServerError)
                        .resizable()
                        .frame(width: 223, height: 223)
                        .scaledToFit()
                    Text(errorType.rawValue)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ErrorView(errorType: .noInternet)
}
