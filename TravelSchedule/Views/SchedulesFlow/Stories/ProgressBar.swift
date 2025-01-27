import SwiftUI

struct ProgressBar: View {
    
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: geometry.size.width, height: 6)
                    .foregroundColor(.ypWhiteUniversal)
                RoundedRectangle(cornerRadius: 6)
                    .frame(
                        width: min(progress * geometry.size.width, geometry.size.width),
                        height: 6)
                    .foregroundColor(.ypBlue)
            }
            .mask {
                MaskView(numberOFSections: numberOfSections)
            }
        }
    }
}

#Preview {
    ProgressBar(numberOfSections: 5, progress: 0.3)
}
