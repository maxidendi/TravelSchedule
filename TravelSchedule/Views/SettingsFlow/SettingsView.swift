import SwiftUI

struct SettingsView: View {
    
    //MARK: - Properties
    
    @State private var isDarkTheme: Bool
    @ObservedObject var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        isDarkTheme = viewModel.isDarkModeEnabled
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            Toggle("Темная тема",
                    isOn: $isDarkTheme)
            .onChange(of: isDarkTheme) { _ in
                viewModel.toggleDarkMode()
            }
            .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
            NavigationLink(destination: UserAgreementView(urlString: viewModel.urlString)) {
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
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
