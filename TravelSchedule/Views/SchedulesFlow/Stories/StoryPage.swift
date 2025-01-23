import SwiftUI

struct StoryPage: View {
    
    let story: Story
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypBlackUniversal
                .ignoresSafeArea()
            Image(story.image)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(.top, 7)
                .padding(.bottom, 17)
                .padding(.horizontal, .zero)
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                        .foregroundStyle(Color.ypWhiteUniversal)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                        .foregroundStyle(.ypWhiteUniversal)
                }
                .padding(.init(top: 0, leading: 16, bottom: 57, trailing: 16))
            }
        }
    }
}

#Preview {
    StoryPage(story: Story(
        image: .story1,
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"))
}
