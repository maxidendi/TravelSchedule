import SwiftUI

@MainActor
struct ScheduleView: View {
    
    //MARK: - Properties

    @ObservedObject var store: SearchStore
    @ObservedObject var router: Router
    @ObservedObject var citiesViewModel: CitiesListViewModel

    //MARK: - Body

    var body: some View {
        StoriesPreviewList(packs: StoriesPack.mockPacks)
            .frame(height: 188)
        VStack {
            HStack {
                VStack {
                    Group {
                        TextField(
                            text: $store.fromText,
                            label: {Text("Откуда").foregroundColor(.ypGray)})
                        .gesture(TapGesture().onEnded {
                            router.push(.citiesList(.from))
                        })
                        TextField(
                            text: $store.toText,
                            label: {
                            Text("Куда").foregroundColor(.ypGray)})
                        .gesture(TapGesture().onEnded {
                            router.push(.citiesList(.to))
                        })}
                    .tint(.clear)
                    .foregroundColor(.ypBlackUniversal)
                    .font(.system(size: 17))
                    .frame(height: 48)
                    .padding(.leading, 16)
                }
                .background(Color.white.cornerRadius(20))
                .padding(.all, 16)
                Button(action: store.resetDirections) {
                    Image(.changeScheduleIcon)
                        .renderingMode(.template)
                        .tint(.ypBlue)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color.white))
                        .padding(.trailing, 16)
                }
            }
            .background(Color.ypBlue.cornerRadius(20))
            .padding(.horizontal, 16)
            if !store.fromText.isEmpty && !store.toText.isEmpty {
                Button(
                    action: { router.push(.carriersList) },
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 150, height: 60)
                                .foregroundColor(.ypBlue)
                            Text("Найти")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.ypWhiteUniversal)
                        }
                    })
            }
            Spacer()
        }
        .padding(.top, 20)
        .ignoresSafeArea()
        .navigationTitle("")
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(for: Paths.self) { path in
            switch path {
            case .citiesList(let direction):
                CitiesListView(direction: direction, viewModel: citiesViewModel)
                    .environmentObject(router)
                    .environmentObject(store)
            case .stationsList(let stations, let direction):
                StationsListView(stationsList: stations, direction: direction)
                    .environmentObject(router)
                    .environmentObject(store)
            case .carriersList:
                RoutesListView()
                    .environmentObject(router)
                    .environmentObject(store)
            }
        }
    }
}

#Preview {
    ScheduleView(store: SearchStore(), router: Router.shared, citiesViewModel: CitiesListViewModel())
}
