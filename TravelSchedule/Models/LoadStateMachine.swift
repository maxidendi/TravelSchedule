import Foundation

final class LoadStateMachine: ObservableObject {
    @Published var state: LoadState = .loading
}

enum LoadState {
    case loading
    case loaded
    case error(ErrorType)
}
