import Observation
import SwiftUI

/// App-wide state. `@Observable` so views only update when the properties they read change
/// (Apple: Understanding and improving SwiftUI performance).
@Observable
final class AppModel {
    enum Destination: Hashable {
        case home, search, settings
    }

    var selectedTab: Destination = .home
    var searchText = ""

    /// Example of off-main-actor work. With main-actor-by-default isolation, mark CPU-heavy
    /// functions `@concurrent` so they never block the UI.
    @concurrent
    nonisolated static func expensiveWork(_ input: [Int]) async -> Int {
        input.reduce(0, +)
    }
}
