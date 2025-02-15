import SwiftUI

struct FiltersView: View {
    
    //MARK: - Init
    
    init(
        routesViewModel: RoutesListViewModel
    ) {
        self.routesViewModel = routesViewModel
        filterMorning = routesViewModel.departureFilters.contains(.morning)
        filterAfternoon = routesViewModel.departureFilters.contains(.afternoon)
        filterEvening = routesViewModel.departureFilters.contains(.evening)
        filterNight = routesViewModel.departureFilters.contains(.night)
        switch routesViewModel.isTransferredFilter {
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
    @ObservedObject var routesViewModel: RoutesListViewModel

    @State private var filterMorning: Bool
    @State private var filterAfternoon: Bool
    @State private var filterEvening: Bool
    @State private var filterNight: Bool
    @State private var filterIsTransfered: Bool
    @State private var filterIsNotTransfered: Bool
    
    private var filters: Set<DepartureTimes> {
        var filters: Set<DepartureTimes> = []
        if filterMorning { filters.insert(.morning) }
        if filterAfternoon { filters.insert(.afternoon) }
        if filterEvening { filters.insert(.evening) }
        if filterNight { filters.insert(.night) }
        return filters
    }
    private var isTransfered: Bool? {
        filterIsTransfered ? true : filterIsNotTransfered ? false : nil
    }
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    headerText("Время отправления")
                    checkBoxToggles
                    headerText("Показывать варианты с пересадками")
                    radioToggles
                }
                .padding(.horizontal ,16)
                Spacer(minLength: 60)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 16)
            if checkFilters() {
                overlayButton
            }
        }
        .navigationTitle("")
        .toolbarRole(.editor)
    }
    
    //MARK: - Methods
    
    private func headerText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.ypBlack)
            .padding(.vertical, 16)
    }
    
    private func checkFilters() -> Bool {
        filterMorning || filterAfternoon || filterEvening ||
        filterNight || filterIsTransfered || filterIsNotTransfered ||
        !routesViewModel.departureFilters.isEmpty ||
        routesViewModel.isTransferredFilter != nil
    }
    
    //MARK: - Subviews
    
    private var overlayButton: some View {
        VStack {
            Spacer()
            Button(
                action: {
                    routesViewModel.setFilters(filters, isTransfered)
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
    
    private var checkBoxToggles: some View {
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
        .toggleStyle(CheckboxStyle(imageConfig: .box))
    }
    
    private var radioToggles: some View {
        Group {
            Toggle(Transfer.yes.rawValue,
                   isOn: $filterIsTransfered)
            .onChange(of: filterIsNotTransfered) { transferred in
                if filterIsTransfered {
                    filterIsTransfered = !transferred
                }
            }
            Toggle(Transfer.no.rawValue,
                   isOn: $filterIsNotTransfered)
            .onChange(of: filterIsTransfered) { notTransferred in
                if filterIsNotTransfered {
                    filterIsNotTransfered = !notTransferred
                }
            }
        }
        .frame(height: 60)
        .font(.system(size: 17, weight: .regular))
        .toggleStyle(CheckboxStyle(imageConfig: .circle))
    }
}

#Preview {
    FiltersView(routesViewModel: RoutesListViewModel())
}
