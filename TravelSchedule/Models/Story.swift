import Foundation

struct Story: Hashable, Sendable {
    let image: ImageResource
    let title: String
    let description: String
}
