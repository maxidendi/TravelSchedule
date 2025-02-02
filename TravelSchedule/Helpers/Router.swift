import SwiftUI

@MainActor
final class Router: ObservableObject {
    
    //MARK: - Properties
        
    @Published var path: [Paths] = []
    
    static let shared = Router()
    private init() {}
    
    //MARK: - Methods
    
    func push(_ newPath: Paths) {
        path.append(newPath)
    }
    
    func pop() {
        if path.count > 1 {
            path.removeLast()
        }
    }
    
    func clear() {
        if path.count > 1 {
            path.removeAll()
    }
    }
}
