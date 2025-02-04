import Foundation

struct StoriesPack: Identifiable, Sendable {
    var id: UUID = UUID()
    let image: ImageResource
    let stories: [Story]
    let description: String
    var isWatched: Bool = false
    
    mutating func markAsWatched() {
        isWatched = true
    }
}

extension StoriesPack {
    static let mockPacks: [StoriesPack] = [
        StoriesPack(
            image: .storyPreview1,
            stories: [
                Story(
                    image: .story1,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story2,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview2,
            stories: [
                Story(
                    image: .story3,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story4,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview3,
            stories: [
                Story(
                    image: .story5,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story6,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview4,
            stories: [
                Story(
                    image: .story7,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story8,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview5,
            stories: [
                Story(
                    image: .story9,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story10,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview6,
            stories: [
                Story(
                    image: .story11,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story12,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview7,
            stories: [
                Story(
                    image: .story13,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story14,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview8,
            stories: [
                Story(
                    image: .story15,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story16,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
        StoriesPack(
            image: .storyPreview9,
            stories: [
                Story(
                    image: .story17,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                Story(
                    image: .story18,
                    title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                    description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text")
            ],
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
    ]
}
