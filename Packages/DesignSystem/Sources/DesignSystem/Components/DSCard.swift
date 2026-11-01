import SwiftUI

/// A content-layer card: solid surface, fixed outer radius, concentric children.
///
/// Cards never use glass (glass is for controls) and never use one-sided borders or accent
/// stripes; separation comes from fill, spacing and an even hairline when needed.
public struct DSCard<Content: View>: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorSchemeContrast) private var contrast
    private let padding: CGFloat
    private let content: Content

    public init(padding: CGFloat = Spacing.l, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.colors.surface, in: .rect(cornerRadius: Radius.card))
            .overlay {
                // Even hairline on all sides, only when Increase Contrast is on.
                if contrast == .increased {
                    RoundedRectangle(cornerRadius: Radius.card).strokeBorder(theme.colors.separator, lineWidth: 1)
                }
            }
            .dsContainer(cornerRadius: Radius.card)
    }
}
