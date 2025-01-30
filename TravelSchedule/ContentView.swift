import SwiftUI
import OpenAPIURLSession

@MainActor
struct ContentView: View {
    
    //MARK: - Properties
    
    @Binding var isDarkModeEnabled: Bool
//    @StateObject private var store = ScheduleViewModel()
//    @StateObject private var citiesViewModel = CitiesListViewModel()
    @StateObject private var router = Router.shared
    
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
                    SettingsView(isDarkTheme: $isDarkModeEnabled)
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
//        .task {
//            await citiesViewModel.getCities()
//        }
    }
}

#Preview {
    ContentView(isDarkModeEnabled: .constant(false))
}
