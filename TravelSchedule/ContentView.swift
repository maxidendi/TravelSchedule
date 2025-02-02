import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    //MARK: - Properties
    
    @StateObject private var router = Router.shared
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    //MARK: - Body
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                VStack {
                    ScheduleView(router: router)
                    Divider()
                }
                .tabItem {
                    Image(.scheduleTabIcon)
                        .renderingMode(.template)
                }
                VStack {
                    SettingsView(viewModel: settingsViewModel)
                    Divider()
                }
                .tabItem {
                    Image(.settingsTabIcon)
                        .renderingMode(.template)
                }
            }
            .accentColor(.ypBlack)
        }
        .tint(.ypBlack)
        .environment(\.colorScheme, settingsViewModel.isDarkModeEnabled ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
