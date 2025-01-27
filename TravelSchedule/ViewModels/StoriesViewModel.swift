import Foundation
import Combine

final class StoriesViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published private(set) var storiesPacks: [StoriesPack]
    @Published private(set) var selectedStoriesPackIndex = 0
    
    init(storiesPacks: [StoriesPack] = StoriesPack.mockPacks) {
        self.storiesPacks = storiesPacks
    }
    
    //MARK: - Methods
    
    func getCurrentStoriesPack() -> StoriesPack {
        storiesPacks[selectedStoriesPackIndex]
    }
    
    func setSelectedStoriesPackIndex(_ storiesPack: StoriesPack) {
        guard let index = storiesPacks.firstIndex(where: { $0.id == storiesPack.id }) else { return }
        selectedStoriesPackIndex = index
    }
    
    func nextPack() {
        selectedStoriesPackIndex = (selectedStoriesPackIndex + 1) % storiesPacks.count
    }
    
    func previousPack() {
        selectedStoriesPackIndex = (selectedStoriesPackIndex - 1 + storiesPacks.count) % storiesPacks.count
    }
    
    func setCurrentStoriesPackAsWatched() {
        storiesPacks[selectedStoriesPackIndex].isWatched = true
    }
}
