import SwiftUI

// Glass is only for small floating controls: tab bar, toolbars, mini-player strips, floating
// buttons. Never content, and never sheets: see-through sheets look muddy, so use `dsSolidSheet()`.
// Prefer system bars and `.buttonStyle(.glass/.glassProminent)`; use these helpers only for custom
// floating controls, grouped in `DSGlassCluster`. The system adapts glass to accessibility settings.

/// Which glass variant to use for a custom floating control.
public enum DSGlassVariant: Sendable {
    /// Default. Blurs and adjusts luminosity so labels stay legible over any content.
    case regular
    /// Highly translucent. Only over photos or video; add `dsMediaDimming()` behind bright media.
    case clear
}

extension View {
    /// Liquid Glass behind a custom floating control, in a capsule.
    public func dsGlass(_ variant: DSGlassVariant = .regular, tint: Color? = nil, interactive: Bool = true) -> some View {
        glassEffect(Self.makeGlass(variant, tint: tint, interactive: interactive))
    }

    /// Liquid Glass behind a custom floating control, in a custom shape.
    public func dsGlass(_ variant: DSGlassVariant = .regular, tint: Color? = nil, interactive: Bool = true, in shape: some Shape) -> some View {
        glassEffect(Self.makeGlass(variant, tint: tint, interactive: interactive), in: shape)
    }

    /// Solid themed background for a sheet's content, replacing the default see-through glass.
    /// Apply to the root view inside `.sheet { }`.
    public func dsSolidSheet() -> some View {
        modifier(DSSolidSheetModifier())
    }

    /// A 35% dark layer for clear glass placed over bright media (HIG Materials).
    public func dsMediaDimming(_ isBright: Bool = true) -> some View {
        overlay { if isBright { Color.black.opacity(0.35).allowsHitTesting(false) } }
    }

    private static func makeGlass(_ variant: DSGlassVariant, tint: Color?, interactive: Bool) -> Glass {
        var glass: Glass = variant == .clear ? .clear : .regular
        if let tint { glass = glass.tint(tint) }
        if interactive { glass = glass.interactive() }
        return glass
    }
}

/// A row of floating glass buttons that blend and morph together.
///
/// ```swift
/// DSGlassCluster {
///     DSIconButton("Search", systemImage: "magnifyingglass") { ... }
///     DSIconButton("Share", systemImage: "square.and.arrow.up") { ... }
/// }
/// ```
public struct DSGlassCluster<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    // Performance: build the content once in init instead of storing an escaping closure.
    public init(spacing: CGFloat = Spacing.s, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        GlassEffectContainer(spacing: spacing) {
            HStack(spacing: spacing) { content }
        }
    }
}

private struct DSSolidSheetModifier: ViewModifier {
    @Environment(\.theme) private var theme

    func body(content: Content) -> some View {
        content.presentationBackground(theme.colors.surface)
    }
}
