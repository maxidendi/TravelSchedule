import SwiftUI

struct StoryPreview: View {
    let pack: StoriesPack
    
    var body: some View {
        ZStack{
            Image(pack.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(pack.isWatched ? 0.5 : 1)
            VStack {
                Spacer()
                Text(pack.description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypWhiteUniversal)
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .padding(.init(top: .zero, leading: 8, bottom: 12, trailing: 8))
            }
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(pack.isWatched ? .clear : .ypBlue , lineWidth: 4)
        )
    }
}

#Preview {
    StoryPreview(pack: StoriesPack.mockPacks[0])
}
