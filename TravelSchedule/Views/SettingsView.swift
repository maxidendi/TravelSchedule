import SwiftUI

struct SettingsView: View {
    
    //MARK: - Properties
    
    @Binding var isDarkTheme: Bool
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            Toggle("Темная тема",
                    isOn: $isDarkTheme)
            .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
            NavigationLink(destination: UserAgreementView()) {
                ListRow(text: "Пользовательское соглашение")
            }
            .foregroundColor(.ypBlack)
            Spacer()
            Group {
                Text("Приложение использует API «Яндекс.Расписания»")
                    .padding(.bottom, 16)
                Text("Версия 1.0 (beta)")
            }
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.ypBlack)
            .lineLimit(nil)
        }
        .navigationTitle("")
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        Divider()
    }
}

#Preview {
    SettingsView(isDarkTheme: .constant(false))
}
