import SwiftUI
import Combine

struct StoryView: View {
    
    //MARK: - Properties
    
    @Binding var isPresenting: Bool
    
    @ObservedObject private var storiesViewModel: StoriesViewModel
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var isSwiped: Bool = false
    @State private var dragOffset: CGSize = .zero
    
    private var configuration: TimerConfiguration { TimerConfiguration(storiesCount: storiesPack.stories.count) }
    private var storiesPack: StoriesPack { storiesViewModel.getCurrentStoriesPack() }
    private var currentStory: Story { storiesViewModel.getCurrentStoriesPack().stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(storiesPack.stories.count)) }
    
    init(
        isPresenting: Binding<Bool>,
        storiesViewModel: ObservedObject<StoriesViewModel>
    ) {
        self._isPresenting = isPresenting
        self._storiesViewModel = storiesViewModel
        let storiesCount = storiesViewModel.wrappedValue.storiesPacks[storiesViewModel.wrappedValue.selectedStoriesPackIndex].stories.count
        let configuration = TimerConfiguration(storiesCount: storiesCount)
        timer = Self.createTimer(configuration: configuration)
    }
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                StoryPage(story: currentStory)
                progressBar
                closeButton
            }
            .onAppear(perform: startTimer)
            .onDisappear(perform: stopTimer)
            .onReceive(timer) { _ in timerTick() }
            .gesture(dragGesture(geometry: geometry))
            .onTapGesture { handleTapGesture(geometry: geometry, gesture: $0) }
        }
    }
    
    //MARK: - Subviews
    
    private var progressBar: some View {
        ProgressBar(
            numberOfSections: storiesPack.stories.count,
            progress: progress)
            .padding(.top, 35)
            .padding(.horizontal, 12)
    }
    
    private var closeButton: some View {
        CloseButton(action: { isPresenting = false })
            .padding(.top, 57)
            .padding(.trailing, 12)
    }
    
    //MARK: - Methods
    
    private enum ChangeStory {
        case next
        case previous
    }
    
    private func changeStory(to change: ChangeStory) {
        switch change {
        case .next:
            storiesViewModel.nextPack()
        case .previous:
            storiesViewModel.previousPack()
        }
        storiesViewModel.setCurrentStoriesPackAsWatched()
        resetTimer()
        progress = 0
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
        withAnimation {
            if nextProgress >= 1 {
                changeStory(to: .next)
            } else {
                progress = nextProgress
            }
        }
    }
    
    private func nextStory() {
        let nextStoryProgress = CGFloat(currentStoryIndex + 1) / CGFloat(storiesPack.stories.count)
        withAnimation {
            if nextStoryProgress >= 1 {
                changeStory(to: .next)
            } else {
                progress = nextStoryProgress
            }
        }
    }
    
    private func previousStory() {
        let nextStoryProgress = CGFloat(currentStoryIndex - 1) / CGFloat(storiesPack.stories.count)
        withAnimation {
            if nextStoryProgress < 0 {
                changeStory(to: .previous)
            } else {
                progress = nextStoryProgress
            }
        }
    }
    
    private func startTimer() {
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private func stopTimer() {
        cancellable?.cancel()
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
    
    private func dragGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 50)
            .onChanged { value in
                isSwiped = true
                dragOffset = value.translation
                if dragOffset.height > 100 {
                    isPresenting = false
                }
            }
            .onEnded { value in
                isSwiped = false
                dragOffset = .zero
                withAnimation {
                    if value.location.x > geometry.size.width / 2 {
                        changeStory(to: .previous)
                    } else {
                        changeStory(to: .next)
                    }
                }
            }
    }
    
    private func handleTapGesture(geometry: GeometryProxy, gesture: CGPoint) {
        guard !isSwiped else { return }
        withAnimation {
            if gesture.x > geometry.size.width / 2 {
                nextStory()
                resetTimer()
            } else {
                previousStory()
                resetTimer()
            }
        }
    }
}

#Preview {
    @ObservedObject var viewModel = StoriesViewModel()
    StoryView(isPresenting: .constant(true), storiesViewModel: _viewModel)
}


//Extension with mock stories

extension StoryView {
    static let stories = [
        Story(
            image: .story1,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        Story(
            image: .story2,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        Story(
            image: .story3,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        Story(
            image: .story4,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        Story(
            image: .story5,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        Story(
            image: .story6,
            title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
    ]
}
