import SwiftUI

enum DepartureTimes: String, Hashable {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    case none
    
    static func from(date: Date?) -> DepartureTimes {
        guard let date else { return none }
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 0...5: return .night
        case 6...11: return .morning
        case 12...17: return .afternoon
        case 18...23: return .evening
        default:
            return none
        }
    }
}

enum Transfer: String, Hashable {
    case yes = "Да"
    case no = "Нет"
    case none
}

struct FiltersView: View {
    
    //MARK: - Init
    
    init(
        departureFilters: Binding<Set<DepartureTimes>>,
        isTransfered: Binding<Bool?>
    ) {
        self._departureFilters = departureFilters
        self._isTransferedFilter = isTransfered
        self.filterMorning = departureFilters.wrappedValue.contains(.morning)
        self.filterAfternoon = departureFilters.wrappedValue.contains(.afternoon)
        self.filterEvening = departureFilters.wrappedValue.contains(.evening)
        self.filterNight = departureFilters.wrappedValue.contains(.night)
        switch isTransfered.wrappedValue {
        case .none:
            filterIsTransfered = false
            filterIsNotTransfered = false
        case .some(let isTransfered):
            filterIsTransfered = isTransfered
            filterIsNotTransfered = !isTransfered
        }
    }
    
    //MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    @Binding var departureFilters: Set<DepartureTimes>
    @Binding var isTransferedFilter: Bool?
    @State private var filterMorning: Bool
    @State private var filterAfternoon: Bool
    @State private var filterEvening: Bool
    @State private var filterNight: Bool
    @State private var filterIsTransfered: Bool
    @State private var filterIsNotTransfered: Bool
    @EnvironmentObject var store: SearchStore
    
    //MARK: - Methods
    
    private func setFilters() {
        if filterMorning == true { departureFilters.insert(.morning) } else { departureFilters.remove(.morning) }
        if filterAfternoon == true { departureFilters.insert(.afternoon) } else { departureFilters.remove(.afternoon) }
        if filterEvening == true { departureFilters.insert(.evening) } else { departureFilters.remove(.evening) }
        if filterNight == true { departureFilters.insert(.night) } else { departureFilters.remove(.night) }
        if filterIsTransfered == true { isTransferedFilter = true }
        if filterIsNotTransfered == true { isTransferedFilter = false }
        if filterIsTransfered == false && filterIsNotTransfered == false { isTransferedFilter = nil }
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
                    Text("Показывать варианты с пересадками")
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
                Spacer(minLength: 60)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 16)
            if filterMorning == true ||
                filterAfternoon == true ||
                filterEvening == true ||
                filterNight == true ||
                filterIsTransfered == true ||
                filterIsNotTransfered == true ||
                !departureFilters.isEmpty ||
                isTransferedFilter != nil {
                VStack {
                    Spacer()
                    Button(
                        action: {
                            setFilters()
                            dismiss()
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
        .toolbarBackground(.ypWhite, for: .navigationBar)
    }
}

#Preview {
    FiltersView(departureFilters: .constant([]), isTransfered: .constant(.none))
        .environmentObject(SearchStore())
}
