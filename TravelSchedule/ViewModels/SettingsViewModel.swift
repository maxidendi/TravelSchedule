import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    //MARK: - Properties and init
    
    @Published var isDarkModeEnabled: Bool
    @Published private(set) var urlString: String
    private let store = UserDefaults.standard
    
    init() {
        self.isDarkModeEnabled = store.bool(forKey: Constants.isDarkThemeKey)
        self.urlString = Constants.API.agreementURLString
    }
    
    //MARK: - Methods
    
    func toggleDarkMode() {
        isDarkModeEnabled.toggle()
        store.set(isDarkModeEnabled, forKey: Constants.isDarkThemeKey)
    }
}
