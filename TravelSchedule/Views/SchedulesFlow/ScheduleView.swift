import SwiftUI

struct ScheduleView: View {
    
    //MARK: - Properties

    @Binding var path: [Paths]
    @ObservedObject var viewModel: ScheduleViewModel

    //MARK: - Body

    var body: some View {
        StoriesPreviewList(storiesViewModel: StoriesViewModel())
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
    }
    
    //MARK: - Subviews
    
    private var scheduleSearchBar: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Group {
                    Text(viewModel.fromText.isEmpty ?
                         "Откуда\(String(repeating: " ", count: 50))" :
                            viewModel.fromText)
                    .foregroundStyle(viewModel.fromText.isEmpty ? .ypGray : .ypBlackUniversal)
                    .onTapGesture {
                        path.append(.citiesList(.from))
                    }
                    Text(viewModel.toText.isEmpty ?
                         "Куда\(String(repeating: " ", count: 50))" :
                            viewModel.toText)
                    .foregroundStyle(viewModel.toText.isEmpty ? .ypGray : .ypBlackUniversal)
                    .onTapGesture {
                        path.append(.citiesList(.to))
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
            .padding([.vertical, .leading], 16)
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
            action: { path.append(.carriersList) },
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 150, height: 60)
                        .foregroundStyle(.ypBlue)
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypWhiteUniversal)
                }
            })
    }
}

#Preview {
    ScheduleView(path: .constant([]), viewModel: ScheduleViewModel())
}
