import SwiftUI

/// Named motion tokens. Pick by intent, not by duration.
nonisolated public enum MotionToken: CaseIterable, Sendable {
    /// Small state changes: toggles, selection, symbol swaps.
    case quick
    /// Most UI transitions: content appearing, layout changes.
    case standard
    /// Larger, deliberate moments: a sheet's contents arriving, a hero change.
    case emphasized
    /// Ambient or decorative motion. Disabled entirely under Reduce Motion.
    case ambient
}

/// The app's motion personality. Agreed with the user on the first session (see CLAUDE.md).
nonisolated public struct MotionStyle: Sendable, Equatable {
    public var quick: Animation
    public var standard: Animation
    public var emphasized: Animation
    public var ambient: Animation
    /// Used for every token when Reduce Motion is on: a short fade-friendly ease with no bounce.
    public var reduced: Animation

    public init(quick: Animation, standard: Animation, emphasized: Animation, ambient: Animation, reduced: Animation) {
        self.quick = quick
        self.standard = standard
        self.emphasized = emphasized
        self.ambient = ambient
        self.reduced = reduced
    }

    /// Calm, system-like defaults. Spring-based so motion can be interrupted mid-flight.
    public static let calm = MotionStyle(
        quick: .snappy(duration: 0.2),
        standard: .smooth(duration: 0.35),
        emphasized: .spring(duration: 0.5, bounce: 0.15),
        ambient: .easeInOut(duration: 2).repeatForever(autoreverses: true),
        reduced: .easeInOut(duration: 0.15)
    )

    /// HIG (Accessibility > Cognitive): under Reduce Motion, tighten springs, remove bounce,
    /// replace movement with fades, and stop repeating or ambient animation.
    public func animation(_ token: MotionToken, reduceMotion: Bool) -> Animation? {
        if reduceMotion {
            return token == .ambient ? nil : reduced
        }
        return switch token {
        case .quick: quick
        case .standard: standard
        case .emphasized: emphasized
        case .ambient: ambient
        }
    }
}

private struct DSAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let token: MotionToken
    let value: V

    func body(content: Content) -> some View {
        content.animation(theme.motion.animation(token, reduceMotion: reduceMotion), value: value)
    }
}

private struct DSTransitionModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let transition: AnyTransition

    func body(content: Content) -> some View {
        content.transition(reduceMotion ? .opacity : transition)
    }
}

extension View {
    /// Animates changes to `value` with a motion token, falling back automatically under Reduce Motion.
    public func dsAnimation<V: Equatable>(_ token: MotionToken = .standard, value: V) -> some View {
        modifier(DSAnimationModifier(token: token, value: value))
    }

    /// Uses `transition` normally and a plain fade under Reduce Motion.
    public func dsTransition(_ transition: AnyTransition) -> some View {
        modifier(DSTransitionModifier(transition: transition))
    }
}

/// Explicit animations from actions: `withDSAnimation(.quick, theme: theme, reduceMotion: reduceMotion) { ... }`.
public func withDSAnimation<Result>(
    _ token: MotionToken = .standard,
    theme: Theme,
    reduceMotion: Bool,
    _ body: () throws -> Result
) rethrows -> Result {
    try withAnimation(theme.motion.animation(token, reduceMotion: reduceMotion), body)
}
