import SwiftUI

final class Router: ObservableObject {
    
    //MARK: - Properties
    
    static let shared = Router()
    private init() {}
    @Published var path: [Paths] = []
    
    //MARK: - Methods
    
    func push(_ path: Paths) {
        DispatchQueue.main.async {
            self.path.append(path)
        }
    }
    
    func pop() {
        DispatchQueue.main.async {
            self.path.removeLast()
        }
    }
    
    func clear() {
        DispatchQueue.main.async {
            self.path.removeAll()
        }
    }
}
