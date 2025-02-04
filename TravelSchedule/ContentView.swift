import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    //MARK: - Properties
    
    @State private var path: [Paths] = []
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    
    //MARK: - Body
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                VStack {
                    ScheduleView(path: $path, viewModel: scheduleViewModel)
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
            .navigationDestination(for: Paths.self) { path in
                switch path {
                case .citiesList(let direction):
                    CitiesListView(direction: direction, path: $path)
                case .stationsList(let city, let direction):
                    StationsListView(direction: direction, city: city, path: $path)
                        .environmentObject(scheduleViewModel)
                case .carriersList:
                    RoutesListView(path: $path)
                        .environmentObject(scheduleViewModel)
                }
            }
        }
        .tint(.ypBlack)
        .environment(\.colorScheme, settingsViewModel.isDarkModeEnabled ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
