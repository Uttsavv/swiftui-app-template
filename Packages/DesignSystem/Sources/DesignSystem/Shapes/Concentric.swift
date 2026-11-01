import SwiftUI

// Top-level containers get a fixed radius via `dsContainer`; nested shapes use concentric corners.

extension View {
    /// Declares this view as a rounded container that nested concentric shapes measure against.
    /// Must be a `RoundedRectangle`, `Capsule` or `Circle` style shape to resolve concentric radii.
    public func dsContainer(cornerRadius: CGFloat = Radius.card) -> some View {
        containerShape(.rect(cornerRadius: cornerRadius))
    }

    /// Fills behind this view with a shape concentric to the nearest container (or the screen).
    public func dsConcentricBackground<S: ShapeStyle>(_ style: S, minimum: CGFloat = Radius.minimumNested) -> some View {
        background(style, in: .rect(corners: .concentric(minimum: .fixed(minimum)), isUniform: true))
    }

    /// Clips this view to a shape concentric with its container.
    public func dsConcentricClip(minimum: CGFloat = Radius.minimumNested) -> some View {
        clipShape(.rect(corners: .concentric(minimum: .fixed(minimum)), isUniform: true))
    }
}
