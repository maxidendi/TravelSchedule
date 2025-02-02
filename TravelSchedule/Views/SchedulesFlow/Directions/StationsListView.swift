import SwiftUI

struct StationsListView: View {

    //MARK: - Properties
    
    let direction: Directions
    let city: City
    @StateObject private var viewModel: StationsListViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    
    //MARK: - Init
    
    init(direction: Directions, city: City) {
        self.direction = direction
        self.city = city
        _viewModel = .init(wrappedValue: .init(city: city))
    }
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            searchBar
            if viewModel.filteredStations().isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            } else {
                citiesList
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
    
    //MARK: - Subviews
    
    private var searchBar: some View {
        HStack {
            TextField(text: $viewModel.searchText, label: {
                Text("Введите запрос")
                    .foregroundColor(.ypGray)
            })
            .frame(height: 36)
            .padding(.horizontal, 33)
            .background(.ypLightGray)
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.ypGray)
                        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    if $viewModel.searchText.wrappedValue.count > 0 {
                        Button(action: {
                            $viewModel.searchText.wrappedValue = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.ypGray)
                                .padding(.trailing, 8)
                        }
                    }
                })
        }
        .padding(.horizontal, 16)
    }
    
    private var citiesList: some View {
        List(viewModel.filteredStations(), id: \.self) { station in
            ListRow(text: station.title)
                .padding(.horizontal, 16)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(.zero))
                .onTapGesture {
                    switch direction {
                    case .from:
                        scheduleViewModel.setupCityAndStation(
                            city.title,
                            station.title,
                            direction: .from)
                        scheduleViewModel.setupStationCodes(station.code, .from)
                        router.clear()
                    case .to:
                        scheduleViewModel.setupCityAndStation(
                            city.title,
                            station.title,
                            direction: .to)
                        scheduleViewModel.setupStationCodes(station.code, .to)
                        router.clear()
                    }
                }
        }
        .listStyle(.inset)
    }
}

#Preview {
    StationsListView(direction: .from, city: City(title: "", stations: []))
}
