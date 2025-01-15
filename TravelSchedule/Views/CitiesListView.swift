import SwiftUI

struct CitiesListView: View {
    
    //MARK: - Properties
    
    let direction: Directions
    @EnvironmentObject var router: Router
    @EnvironmentObject var store: SearchStore
    @ObservedObject var viewModel: CitiesListViewModel
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
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
            switch viewModel.stateMachine.state {
            case .loading:
                Spacer()
                ProgressView()
                Spacer()
            case .error(let error):
                Spacer()
                ErrorView(errorType: error)
                Spacer()
            case .loaded:
                if viewModel.filteredCities().isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                } else {
                    List(viewModel.filteredCities(), id: \.id) { city in
                        ListRow(text: city.title)
                            .padding(.horizontal, 16)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(.zero))
                            .onTapGesture {
                                switch direction {
                                case .from:
                                    store.cityFrom = city.title
                                    router.push(.stationsList(city.stations, .from))
                                case .to:
                                    store.cityTo = city.title
                                    router.push(.stationsList(city.stations, .to))
                                }
                            }
                        }
                    .listStyle(.inset)
                }
            }
        }
        .onAppear {
            viewModel.searchText = ""
        }
    }
}

#Preview {
    CitiesListView(direction: .from, viewModel: CitiesListViewModel())
}
