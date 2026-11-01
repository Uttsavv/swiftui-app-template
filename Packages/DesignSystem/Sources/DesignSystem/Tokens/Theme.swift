import SwiftUI

/// Everything a view needs to look on-brand. Read it with `@Environment(\.theme)`.
public struct Theme: Sendable {
    public var palette: Palette
    public var typography: Typography
    public var motion: MotionStyle

    public init(palette: Palette = .placeholder, typography: Typography = .init(), motion: MotionStyle = .calm) {
        self.palette = palette
        self.typography = typography
        self.motion = motion
    }

    public var colors: ThemeColors { ThemeColors(palette: palette) }

    public static let `default` = Theme()
}

extension EnvironmentValues {
    @Entry public var theme: Theme = .default
}

extension View {
    /// Installs a theme and sets the app-wide tint to its accent.
    ///
    /// HIG (Dark Mode): don't add an in-app light/dark switch; follow the system appearance.
    public func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
            .tint(theme.colors.accent)
    }
}
