import SwiftUI

/// Text roles mapped onto system text styles so Dynamic Type, Bold Text and
/// accessibility sizes all work automatically.
///
/// HIG (Typography): prefer built-in text styles, avoid Ultralight/Thin/Light weights,
/// keep body at 17 pt default and never below 11 pt, and minimise the number of typefaces.
public enum TextRole: CaseIterable, Sendable {
    case largeTitle, title, title2, title3, headline, body, callout, subheadline, footnote, caption, caption2

    public var style: Font.TextStyle {
        switch self {
        case .largeTitle: .largeTitle
        case .title: .title
        case .title2: .title2
        case .title3: .title3
        case .headline: .headline
        case .body: .body
        case .callout: .callout
        case .subheadline: .subheadline
        case .footnote: .footnote
        case .caption: .caption
        case .caption2: .caption2
        }
    }
}

/// Font choices for the app. Change `design` (e.g. `.serif`, `.rounded`) rather than shipping
/// custom fonts unless the brand truly needs one; system fonts get optical sizing for free.
public struct Typography: Sendable, Hashable {
    public var design: Font.Design
    /// Design used for long-form reading text, if different.
    public var readingDesign: Font.Design

    public init(design: Font.Design = .default, readingDesign: Font.Design = .default) {
        self.design = design
        self.readingDesign = readingDesign
    }

    public func font(_ role: TextRole) -> Font {
        .system(role.style, design: design)
    }

    public func readingFont(_ role: TextRole = .body) -> Font {
        .system(role.style, design: readingDesign)
    }
}

private struct DSFontModifier: ViewModifier {
    @Environment(\.theme) private var theme
    let role: TextRole
    let reading: Bool

    func body(content: Content) -> some View {
        content.font(reading ? theme.typography.readingFont(role) : theme.typography.font(role))
    }
}

extension View {
    /// `Text("Hello").dsFont(.headline)`
    public func dsFont(_ role: TextRole) -> some View {
        modifier(DSFontModifier(role: role, reading: false))
    }

    /// Long-form text: reading typeface, loose leading, readable width.
    public func dsReadingText() -> some View {
        modifier(DSFontModifier(role: .body, reading: true))
            .lineSpacing(Spacing.xs)
            .frame(maxWidth: ReadableWidth.body, alignment: .leading)
    }
}
