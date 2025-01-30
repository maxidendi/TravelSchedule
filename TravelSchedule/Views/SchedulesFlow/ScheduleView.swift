import SwiftUI

struct ScheduleView: View {
    
    //MARK: - Properties

    @StateObject private var viewModel = ScheduleViewModel()
    @ObservedObject var router: Router
    @StateObject private var storiesViewModel = StoriesViewModel()

    //MARK: - Body

    var body: some View {
        StoriesPreviewList(storiesViewModel: storiesViewModel)
            .frame(height: 188)
        VStack(spacing: 16) {
            scheduleSearchBar
            if !viewModel.fromText.isEmpty && !viewModel.toText.isEmpty {
                searchButton
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
                CitiesListView(direction: direction)
                    .environmentObject(router)
            case .stationsList(let city, let direction):
                StationsListView(direction: direction, city: city)
                    .environmentObject(router)
                    .environmentObject(viewModel)
            case .carriersList:
                RoutesListView()
                    .environmentObject(router)
                    .environmentObject(viewModel)
            }
        }
    }
    
    //MARK: - Subviews
    
    private var scheduleSearchBar: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Group {
                    Text(viewModel.fromText.isEmpty ?
                         "Откуда\(String(repeating: " ", count: 50))" :
                            viewModel.fromText)
                        .foregroundColor(viewModel.fromText.isEmpty ? .ypGray : .ypBlackUniversal)
                        .onTapGesture {
                            router.push(.citiesList(.from))
                        }
                    Text(viewModel.toText.isEmpty ?
                         "Куда\(String(repeating: " ", count: 50))" :
                            viewModel.toText)
                        .foregroundColor(viewModel.toText.isEmpty ? .ypGray : .ypBlackUniversal)
                        .onTapGesture {
                            router.push(.citiesList(.to))
                        }
                }
                .lineLimit(1)
                .truncationMode(.tail)
                .tint(.ypWhiteUniversal)
                .font(.system(size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 48)
                .padding(.leading, 16)
            }
            .frame(maxWidth: .infinity)
            .background(Color.ypWhiteUniversal.cornerRadius(20))
            .padding(.vertical, 16)
            .padding(.leading, 16)
            Button(action: viewModel.resetDirections) {
                Image(.changeScheduleIcon)
                    .renderingMode(.template)
                    .tint(.ypBlue)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white))
            }
            .padding(.trailing, 16)
        }
        .background(Color.ypBlue.cornerRadius(20))
        .padding(.horizontal, 16)
    }
    
    private var searchButton: some View {
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
}

#Preview {
    ScheduleView(router: Router.shared)
}
