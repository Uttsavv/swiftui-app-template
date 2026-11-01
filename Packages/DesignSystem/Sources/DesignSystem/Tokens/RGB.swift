import Foundation

/// A plain sRGB colour value. Kept free of SwiftUI so contrast can be unit tested.
nonisolated public struct RGB: Sendable, Hashable, CustomStringConvertible {
    public var red: Double
    public var green: Double
    public var blue: Double

    /// `RGB(0x34508A)`
    public init(_ hex: UInt32) {
        red = Double((hex >> 16) & 0xFF) / 255
        green = Double((hex >> 8) & 0xFF) / 255
        blue = Double(hex & 0xFF) / 255
    }

    public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    /// WCAG 2.x relative luminance.
    public var relativeLuminance: Double {
        func channel(_ c: Double) -> Double {
            c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * channel(red) + 0.7152 * channel(green) + 0.0722 * channel(blue)
    }

    /// WCAG 2.x contrast ratio, from 1 to 21.
    public func contrastRatio(with other: RGB) -> Double {
        let a = relativeLuminance, b = other.relativeLuminance
        return (max(a, b) + 0.05) / (min(a, b) + 0.05)
    }

    public var description: String {
        String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
}
