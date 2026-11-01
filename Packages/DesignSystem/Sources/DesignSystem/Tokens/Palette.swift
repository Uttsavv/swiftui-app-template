import SwiftUI

/// The app's semantic colours. Views use roles (`textPrimary`), never raw hex values.
///
/// The default palette is a deliberately neutral placeholder. On the first session in a new
/// app, Claude asks for the colour scheme (see CLAUDE.md) and replaces it here.
public struct Palette: Sendable, Hashable {
    /// Screen background (content layer).
    public var background: ColorToken
    /// Cards and grouped content sitting on `background`.
    public var surface: ColorToken
    /// Content raised above `surface`, and the solid fallback for glass under Reduce Transparency.
    public var surfaceRaised: ColorToken
    /// Primary text and icons.
    public var textPrimary: ColorToken
    /// Secondary text, captions, placeholder-like content.
    public var textSecondary: ColorToken
    /// Hairlines and dividers. Never used as a text colour.
    public var separator: ColorToken
    /// Interactive emphasis: prominent buttons, links, selection. Use sparingly.
    public var accent: ColorToken
    /// Text and icons placed on `accent`.
    public var onAccent: ColorToken
    /// Status colours. Always pair them with a symbol or text, never colour alone.
    public var success: ColorToken
    public var warning: ColorToken
    public var danger: ColorToken

    public init(
        background: ColorToken, surface: ColorToken, surfaceRaised: ColorToken,
        textPrimary: ColorToken, textSecondary: ColorToken, separator: ColorToken,
        accent: ColorToken, onAccent: ColorToken,
        success: ColorToken, warning: ColorToken, danger: ColorToken
    ) {
        self.background = background
        self.surface = surface
        self.surfaceRaised = surfaceRaised
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.separator = separator
        self.accent = accent
        self.onAccent = onAccent
        self.success = success
        self.warning = warning
        self.danger = danger
    }

    /// A pair of colours that must meet a minimum contrast in every appearance.
    public struct ContrastRequirement: Sendable {
        public let name: String
        public let foreground: KeyPath<Palette, ColorToken>
        public let background: KeyPath<Palette, ColorToken>
        /// HIG / WCAG AA: 4.5 for text up to 17 pt, 3 for large or bold text and icons.
        public let minimum: Double
    }

    /// Pairs checked by `PaletteContrastTests`. Add a row whenever you add a pairing to the UI.
    public static let contrastRequirements: [ContrastRequirement] = [
        .init(name: "Primary text on background", foreground: \.textPrimary, background: \.background, minimum: 7),
        .init(name: "Primary text on surface", foreground: \.textPrimary, background: \.surface, minimum: 7),
        .init(name: "Primary text on raised surface", foreground: \.textPrimary, background: \.surfaceRaised, minimum: 4.5),
        .init(name: "Secondary text on background", foreground: \.textSecondary, background: \.background, minimum: 4.5),
        .init(name: "Secondary text on surface", foreground: \.textSecondary, background: \.surface, minimum: 4.5),
        .init(name: "Accent text on background", foreground: \.accent, background: \.background, minimum: 4.5),
        .init(name: "Accent text on surface", foreground: \.accent, background: \.surface, minimum: 4.5),
        .init(name: "Text on accent", foreground: \.onAccent, background: \.accent, minimum: 4.5),
        .init(name: "Danger on background", foreground: \.danger, background: \.background, minimum: 4.5),
        .init(name: "Success icon on background", foreground: \.success, background: \.background, minimum: 3),
        .init(name: "Warning icon on background", foreground: \.warning, background: \.background, minimum: 3),
    ]
}

extension Palette {
    /// Neutral slate placeholder. Replace after the colour-scheme conversation.
    public static let placeholder = Palette(
        background: .init(light: RGB(0xF5F6F8), dark: RGB(0x0F1115), lightHighContrast: RGB(0xFFFFFF), darkHighContrast: RGB(0x000000)),
        surface: .init(light: RGB(0xFFFFFF), dark: RGB(0x181B21), lightHighContrast: RGB(0xFFFFFF), darkHighContrast: RGB(0x101216)),
        surfaceRaised: .init(light: RGB(0xECEEF2), dark: RGB(0x232731), lightHighContrast: RGB(0xE2E5EA), darkHighContrast: RGB(0x262A33)),
        textPrimary: .init(light: RGB(0x15181E), dark: RGB(0xEEF0F4), lightHighContrast: RGB(0x000000), darkHighContrast: RGB(0xFFFFFF)),
        textSecondary: .init(light: RGB(0x545B68), dark: RGB(0xA3AAB7), lightHighContrast: RGB(0x3A404B), darkHighContrast: RGB(0xC9CED8)),
        separator: .init(light: RGB(0xD9DDE4), dark: RGB(0x2C313C), lightHighContrast: RGB(0x8A919E), darkHighContrast: RGB(0x6B7280)),
        accent: .init(light: RGB(0x2F5BD3), dark: RGB(0x8EAEFF), lightHighContrast: RGB(0x1E43A8), darkHighContrast: RGB(0xB5CAFF)),
        onAccent: .init(light: RGB(0xFFFFFF), dark: RGB(0x0F1115), lightHighContrast: RGB(0xFFFFFF), darkHighContrast: RGB(0x000000)),
        success: .init(light: RGB(0x1F7A3D), dark: RGB(0x5FD48A), lightHighContrast: RGB(0x135C2C), darkHighContrast: RGB(0x8BE8AE)),
        warning: .init(light: RGB(0x9A6200), dark: RGB(0xF2B43C), lightHighContrast: RGB(0x7A4D00), darkHighContrast: RGB(0xFFD27A)),
        danger: .init(light: RGB(0xC0322B), dark: RGB(0xFF8A80), lightHighContrast: RGB(0x9A1F19), darkHighContrast: RGB(0xFFB3AC))
    )
}

/// Resolved SwiftUI colours for the current palette: `theme.colors.textPrimary`.
public struct ThemeColors: Sendable {
    let palette: Palette
    public var background: Color { palette.background.color }
    public var surface: Color { palette.surface.color }
    public var surfaceRaised: Color { palette.surfaceRaised.color }
    public var textPrimary: Color { palette.textPrimary.color }
    public var textSecondary: Color { palette.textSecondary.color }
    public var separator: Color { palette.separator.color }
    public var accent: Color { palette.accent.color }
    public var onAccent: Color { palette.onAccent.color }
    public var success: Color { palette.success.color }
    public var warning: Color { palette.warning.color }
    public var danger: Color { palette.danger.color }
}
