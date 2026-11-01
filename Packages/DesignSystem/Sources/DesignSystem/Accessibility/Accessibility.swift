import SwiftUI

extension View {
    /// Guarantees a 44×44 pt hit target without changing the visual size (HIG Accessibility > Mobility).
    public func dsHitTarget() -> some View {
        frame(minWidth: HitTarget.standard, minHeight: HitTarget.standard)
            .contentShape(.rect)
    }

    /// Groups children into one VoiceOver element with a combined label, e.g. a card summary.
    public func dsAccessibilityGroup() -> some View {
        accessibilityElement(children: .combine)
    }
}

/// Switches between a horizontal and vertical layout when Dynamic Type reaches accessibility
/// sizes, so text wraps instead of truncating (HIG Layout: be prepared for text-size changes).
public struct DSAdaptiveStack<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = Spacing.m, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: spacing))
            : AnyLayout(HStackLayout(alignment: .center, spacing: spacing))
        layout { content }
    }
}
