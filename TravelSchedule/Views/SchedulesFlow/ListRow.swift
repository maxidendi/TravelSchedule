import SwiftUI

struct ListRow: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 17))
                .fontWeight(.regular)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 11, height: 19)
                .fontWeight(.semibold)
        }
        .frame(height: 60)
        .contentShape(Rectangle())
    }
}

#Preview {
    ListRow(text: "Moscow")
}
