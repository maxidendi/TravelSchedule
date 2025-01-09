import SwiftUI

struct CheckboxStyle: ToggleStyle {
    enum ImageConfig {
        case box
        case circle
    }
    let imageConfig: ImageConfig
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            switch imageConfig {
                case .box:
                Image(configuration.isOn ? .checkboxOn : .checkboxOff)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.ypBlack)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                case .circle:
                Image(configuration.isOn ? .checkcircleOn : .checkcircleOff)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.ypBlack)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
        }
    }
}

