import SwiftUI

/// Spacing scale in points. Pair with `@ScaledMetric` when spacing should grow with Dynamic Type.
public enum Spacing {
    public static let xxs: CGFloat = 2
    public static let xs: CGFloat = 4
    public static let s: CGFloat = 8
    /// HIG: about 12 pt of padding around bezeled controls.
    public static let m: CGFloat = 12
    public static let l: CGFloat = 16
    /// HIG: about 24 pt around controls without a bezel.
    public static let xl: CGFloat = 24
    public static let xxl: CGFloat = 32
    public static let xxxl: CGFloat = 48
}

/// Corner radii for top-level containers. Anything nested inside a container
/// should use `.concentric` corners instead of a number (see `Shapes/`).
public enum Radius {
    /// Smallest radius a nested concentric shape may shrink to.
    public static let minimumNested: CGFloat = 8
    public static let control: CGFloat = 12
    public static let card: CGFloat = 24
    public static let sheetContent: CGFloat = 28
}

/// Hit-target sizes from the HIG (Accessibility > Mobility).
public enum HitTarget {
    /// Default control size on iOS. Use for every tappable element.
    public static let standard: CGFloat = 44
    /// Absolute minimum. Only for dense, secondary controls.
    public static let minimum: CGFloat = 28
}

/// Readable line length for long-form text, in points (roughly 70 characters of body text).
public enum ReadableWidth {
    public static let body: CGFloat = 640
}
