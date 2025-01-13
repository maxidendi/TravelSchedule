import SwiftUI

@main
struct TravelScheduleApp: App {
    @State private var isDarkModeEnabled: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(isDarkModeEnabled: $isDarkModeEnabled)
                .environment(\.colorScheme, isDarkModeEnabled ? .dark : .light)
        }
    }
}
