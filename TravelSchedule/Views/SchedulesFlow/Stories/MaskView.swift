import SwiftUI

struct MaskView: View {
    let numberOFSections: Int
    var body: some View {
        HStack {
            ForEach(0..<numberOFSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

#Preview {
    MaskView(numberOFSections: 5)
        .padding(12)
}
