import Foundation

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    
    init(carrier: Carrier) {
        self.carrier = carrier
    }
    
    //MARK: - Properties
    
    @Published var carrier: Carrier
}
