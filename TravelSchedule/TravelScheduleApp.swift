import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(isDarkModeEnabled: $isDarkModeEnabled)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}
