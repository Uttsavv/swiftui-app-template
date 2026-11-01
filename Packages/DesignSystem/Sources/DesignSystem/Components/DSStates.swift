import SwiftUI

/// Empty, loading and error states. HIG (Writing, Loading, Feedback): show something
/// immediately, give a clear next step on blank screens, and explain errors plainly.
public struct DSEmptyState: View {
    @Environment(\.theme) private var theme
    private let title: LocalizedStringKey
    private let systemImage: String
    private let message: LocalizedStringKey
    private let actionTitle: LocalizedStringKey?
    private let action: (() -> Void)?

    public init(
        _ title: LocalizedStringKey,
        systemImage: String,
        message: LocalizedStringKey,
        actionTitle: LocalizedStringKey? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.systemImage = systemImage
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            // Theme colour instead of the system secondary label, which can fall below 4.5:1.
            Text(message).foregroundStyle(theme.colors.textSecondary)
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action).buttonStyle(.borderedProminent)
            }
        }
    }
}

/// A status message that never relies on colour alone: icon + text + colour.
public struct DSStatusLabel: View {
    public enum Kind: Sendable { case success, warning, danger }

    @Environment(\.theme) private var theme
    private let text: LocalizedStringKey
    private let kind: Kind

    public init(_ text: LocalizedStringKey, kind: Kind) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        Label(text, systemImage: symbol)
            .foregroundStyle(color)
            .dsFont(.subheadline)
    }

    private var symbol: String {
        switch kind {
        case .success: "checkmark.circle.fill"
        case .warning: "exclamationmark.triangle.fill"
        case .danger: "xmark.octagon.fill"
        }
    }

    private var color: Color {
        switch kind {
        case .success: theme.colors.success
        case .warning: theme.colors.warning
        case .danger: theme.colors.danger
        }
    }
}

/// Section header in title-style capitalization (iOS 26 lists no longer force all caps).
public struct DSSectionHeader: View {
    @Environment(\.theme) private var theme
    private let title: LocalizedStringKey

    public init(_ title: LocalizedStringKey) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .dsFont(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(theme.colors.textPrimary)
            .accessibilityAddTraits(.isHeader)
    }
}
