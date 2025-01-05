import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
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
                Spacer()
                Text("Hello, Settings!")
                Spacer()
                Divider()
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
    ContentView()
}
