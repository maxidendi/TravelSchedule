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
//        .task {
//            do {
//                let client = Client(
//                    serverURL: try! Servers.Server1.url(),
//                    transport: URLSessionTransport())
//                let stationsListService = StationsListService(
//                    client: client,
//                    apikey: Constants.API.yandexScheduleAPIKey)
//                let response = try await stationsListService.getStationsList()
//                print(response.countries?[0].regions?[0] ?? "")
//            } catch {
//                assertionFailure(error.localizedDescription)
//            }
//        }
        .accentColor(.ypBlack)
    }
}

#Preview {
    ContentView(isDarkModeEnabled: .constant(false))
}
