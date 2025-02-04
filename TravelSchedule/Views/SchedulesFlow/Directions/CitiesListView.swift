import SwiftUI

struct CitiesListView: View {
    
    //MARK: - Properties
    
    let direction: Directions
    @Binding var path: [Paths]
    @StateObject private var viewModel = CitiesListViewModel()
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .loading:
                searchBar
                Spacer()
                ProgressView()
                Spacer()
            case .error(let error):
                Spacer()
                ErrorView(errorType: error)
                Spacer()
            case .loaded:
                searchBar
                if viewModel.filteredCities().isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                } else {
                    citiesList
                }
            }
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .task {
            await viewModel.getCities()
        }
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
        List(viewModel.filteredCities(), id: \.id) { city in
            ListRow(text: city.title)
                .padding(.horizontal, 16)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(.zero))
                .onTapGesture {
                    switch direction {
                    case .from:
                        path.append(.stationsList(city, .from))
                    case .to:
                        path.append(.stationsList(city, .to))
                    }
                }
            }
        .listStyle(.inset)
    }
}

#Preview {
    CitiesListView(direction: .from, path: .constant([]))
}
