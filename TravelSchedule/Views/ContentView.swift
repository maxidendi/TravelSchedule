import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    @Binding var isDarkModeEnabled: Bool
    
    var body: some View {
        TabView {
            VStack {
                ScheduleView()
            }
            .tabItem {
                Image(.scheduleTabIcon)
                    .renderingMode(.template)
            }
            VStack {
                SettingsView(isDarkTheme: $isDarkModeEnabled)
            }
            .tabItem {
                Image(.settingsTabIcon)
                    .renderingMode(.template)
            }
        }
        .accentColor(.ypBlack)
    }
}

#Preview {
    ContentView(isDarkModeEnabled: .constant(false))
}
