import SwiftUI

struct StationsListView: View {

    //MARK: - Properties

    private let mockStationsList: [String] = [
        "Киевский вокзал", "Курский вокзал", "Ярославский вокзал",
        "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"
    ]
    
    let direction: Directions
    private var filteredList: [String] {
        text.isEmpty ? mockStationsList :
                       mockStationsList.filter{ $0.localizedCaseInsensitiveContains(text) }
    }
    @EnvironmentObject var router: Router
    @EnvironmentObject var store: SearchStore
    @State var text: String = ""
    
    //MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                TextField("Введите запрос", text: $text)
                    .frame(height: 36)
                    .padding(.horizontal, 33)
                    .background(Color(.ypLightGray))
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
                List {
                    ForEach(filteredList, id: \.self) { station in
                        ListRow(text: station)
                            .padding(.horizontal, 16)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(.zero))
                            .onTapGesture {
                                switch direction {
                                case .from:
                                    store.stationsFrom = station
                                    store.setupfromText()
                                    router.clear()
                                case .to:
                                    store.stationsTo = station
                                    store.setupToText()
                                    router.clear()
                                }
                            }
                    }
                }
                .listStyle(.inset)
            }
        }
    }
}

#Preview {
    StationsListView(direction: .from)
}
