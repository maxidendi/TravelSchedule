import SwiftUI

enum DepartureTimes: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

enum Transfer: String {
    case yes = "Да"
    case no = "Нет"
    case none
}

struct FiltersView: View {
    
    //MARK: - Properties
    
    @State private var filterMorning: Bool = false
    @State private var filterAfternoon: Bool = false
    @State private var filterEvening: Bool = false
    @State private var filterNight: Bool = false
    @State private var filterIsTransfered: Bool = false
    @State private var filterIsNotTransfered: Bool = false
    @EnvironmentObject var router: Router
    @EnvironmentObject var store: SearchStore
    
    //MARK: - Methods
    
    private func setFilters() {
        if filterMorning == true { store.departureFilters.insert(.morning) }
        if filterAfternoon == true { store.departureFilters.insert(.afternoon) }
        if filterEvening == true { store.departureFilters.insert(.evening) }
        if filterNight == true { store.departureFilters.insert(.night) }
        if filterIsTransfered == true { store.isTransfered = .yes }
        if filterIsNotTransfered == true { store.isTransfered = .no }
    }
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                        .padding(.vertical, 16)
                    Group {
                        Toggle(DepartureTimes.morning.rawValue,
                               isOn: $filterMorning)
                        Toggle(DepartureTimes.afternoon.rawValue,
                               isOn: $filterAfternoon)
                        Toggle(DepartureTimes.evening.rawValue,
                               isOn: $filterEvening)
                        Toggle(DepartureTimes.night.rawValue,
                               isOn: $filterNight)
                    }
                    .frame(height: 60)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlack)
                    .toggleStyle(CheckboxStyle(imageConfig: .box))
                    Text("Показать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                        .padding(.vertical, 16)
                    Group {
                        Toggle(Transfer.yes.rawValue,
                               isOn: $filterIsTransfered)
                        .onChange(of: filterIsNotTransfered) { newValue in
                            if filterIsTransfered != false {
                                filterIsTransfered = !newValue
                            }
                        }
                        Toggle(Transfer.no.rawValue,
                               isOn: $filterIsNotTransfered)
                        .onChange(of: filterIsTransfered) { newValue in
                            if filterIsNotTransfered != false {
                                filterIsNotTransfered = !newValue
                            }
                        }
                    }
                    .frame(height: 60)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlack)
                    .toggleStyle(CheckboxStyle(imageConfig: .circle))
                }
                .padding(.horizontal ,16)
            }
            .padding(.bottom, 16)
            if filterMorning == true ||
               filterAfternoon == true ||
               filterEvening == true ||
               filterNight == true ||
               filterIsTransfered == true ||
               filterIsNotTransfered == true {
                VStack {
                    Spacer()
                    Button(
                        action: {
                            setFilters()
                            router.pop()
                        },
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .padding(.horizontal, 16)
                                    .frame(height: 60)
                                    .foregroundColor(.ypBlue)
                                Text("Применить")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.ypWhiteUniversal)
                            }
                        })
                    .padding(.bottom, 24)
                }
            }
        }
    }
}

#Preview {
    FiltersView()
        .environmentObject(SearchStore())
}
