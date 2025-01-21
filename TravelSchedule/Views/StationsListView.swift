import SwiftUI

struct StationsListView: View {

    //MARK: - Properties

    let stationsList: [Station]
    let direction: Directions
    private var filteredList: [Station] {
        text.isEmpty ? stationsList :
                       stationsList.filter{ $0.title.localizedCaseInsensitiveContains(text) }
    }
    @EnvironmentObject var router: Router
    @EnvironmentObject var store: SearchStore
    @State private var text: String = ""
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                TextField(text: $text, label: {
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
                            if $text.wrappedValue.count > 0 {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.ypGray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
            }
                .padding(.horizontal, 16)
            if filteredList.isEmpty {
                Spacer()
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            } else {
                List(filteredList, id: \.self) { station in
                    ListRow(text: station.title)
                        .padding(.horizontal, 16)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(.zero))
                        .onTapGesture {
                            switch direction {
                            case .from:
                                store.stationFromCode = station.code
                                store.stationsFrom = station.title
                                store.setupfromText()
                                router.clear()
                            case .to:
                                store.stationToCode = station.code
                                store.stationsTo = station.title
                                store.setupToText()
                                router.clear()
                            }
                        }
                }
                .listStyle(.inset)
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

#Preview {
    StationsListView(stationsList: [], direction: .from)
}
