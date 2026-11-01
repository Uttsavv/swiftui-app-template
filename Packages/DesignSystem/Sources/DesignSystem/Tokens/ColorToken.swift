import SwiftUI

/// One semantic colour with a value for every appearance the system can ask for.
///
/// HIG (Color, Dark Mode): every custom colour needs light and dark variants, plus an
/// Increase Contrast variant of each that is clearly more differentiated.
public struct ColorToken: Sendable, Hashable {
    public var light: RGB
    public var dark: RGB
    public var lightHighContrast: RGB
    public var darkHighContrast: RGB

    public init(light: RGB, dark: RGB, lightHighContrast: RGB? = nil, darkHighContrast: RGB? = nil) {
        self.light = light
        self.dark = dark
        self.lightHighContrast = lightHighContrast ?? light
        self.darkHighContrast = darkHighContrast ?? dark
    }

    /// Every variant, labelled, for tests and the catalog.
    public var variants: [(name: String, value: RGB)] {
        [("light", light), ("dark", dark), ("light, high contrast", lightHighContrast), ("dark, high contrast", darkHighContrast)]
    }

    /// A dynamic SwiftUI colour that follows Dark Mode and Increase Contrast.
    public var color: Color {
        #if canImport(UIKit)
        Color(uiColor: UIColor { traits in
            let dark = traits.userInterfaceStyle == .dark
            let high = traits.accessibilityContrast == .high
            return UIColor(rgb: dark ? (high ? darkHighContrast : self.dark) : (high ? lightHighContrast : light))
        })
        #elseif canImport(AppKit)
        Color(nsColor: NSColor(name: nil) { appearance in
            let match = appearance.bestMatch(from: [.aqua, .darkAqua, .accessibilityHighContrastAqua, .accessibilityHighContrastDarkAqua])
            let value: RGB = switch match {
            case .darkAqua: dark
            case .accessibilityHighContrastAqua: lightHighContrast
            case .accessibilityHighContrastDarkAqua: darkHighContrast
            default: light
            }
            return NSColor(rgb: value)
        })
        #endif
    }
}

#if canImport(UIKit)
extension UIColor {
    convenience init(rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
}
#elseif canImport(AppKit)
extension NSColor {
    convenience init(rgb: RGB) {
        self.init(srgbRed: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
}
#endif
