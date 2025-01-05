import SwiftUI

struct CarriersListView: View {
    
    //MARK: - Properties
    
    private let mockCarriersList: Carrier = []
    
    @EnvironmentObject var router: Router
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Text("Carriers")
                .font(.headline)
                .padding()
            
            List {
                ForEach(Carriers.allCases) { carrier in
                    NavigationLink(destination: CarrierDetailsView(carrier: carrier)) {
                        Text(carrier.name)
                    }
                }
            }
        }
    }
}

#Preview {
    CarriersListView()
}
