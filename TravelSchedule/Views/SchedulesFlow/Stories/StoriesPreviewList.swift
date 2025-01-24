import SwiftUI

struct StoriesPreviewList: View {
    
    //MARK: - Properties
    
    @ObservedObject var storiesViewModel: StoriesViewModel
    @State private var isPresenting: Bool = false
    
    //MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(storiesViewModel.storiesPacks) { pack in
                    StoryPreview(pack: pack)
                        .onTapGesture {
                            withAnimation {
                                storiesViewModel.setSelectedStoriesPackIndex(pack)
                                storiesViewModel.setCurrentStoriesPackAsWatched()
                                isPresenting.toggle()
                            }
                        }
                        .fullScreenCover(isPresented: $isPresenting) {
                            StoryView(isPresenting: $isPresenting, storiesViewModel: _storiesViewModel)
                        }
                }
            }
            .padding(.init(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    StoriesPreviewList(storiesViewModel: StoriesViewModel(storiesPacks: StoriesPack.mockPacks))
}
