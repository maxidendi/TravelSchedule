import SwiftUI

struct StoriesPreviewList: View {
    let packs: [StoriesPack]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(packs) { pack in
                    StoryPreview(pack: pack)
                }
            }
            .padding(.init(top: 24, leading: 16, bottom: 24, trailing: .zero))
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    StoriesPreviewList(packs: StoriesPack.mockPacks)
}
