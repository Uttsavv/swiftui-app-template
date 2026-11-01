import SwiftUI

/// Button hierarchy (HIG Buttons): one prominent action per view, distinguished by style not size.
///
/// - Primary: `.buttonStyle(.glassProminent)` in bars and floating UI, `.borderedProminent` in content.
/// - Secondary: `.buttonStyle(.glass)` in bars and floating UI, `.bordered` in content.
/// - Destructive: give the button `role: .destructive`; never make it the primary action.
///
/// These are system styles on purpose: they adapt to Liquid Glass, Dynamic Type,
/// Increase Contrast and the button-shapes setting with no extra code.

/// A circular icon-only button for floating controls. Always carries a text label for
/// VoiceOver and Voice Control, and a 44 pt hit target.
public struct DSIconButton: View {
    private let title: LocalizedStringKey
    private let systemImage: String
    private let action: () -> Void

    public init(_ title: LocalizedStringKey, systemImage: String, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .labelStyle(.iconOnly)
                .frame(minWidth: HitTarget.standard, minHeight: HitTarget.standard)
                .contentShape(.circle)
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
    }
}

/// A full-width primary call to action for the content layer, with an optional busy state
/// (HIG: show activity in the button for actions that don't complete instantly).
public struct DSPrimaryButton: View {
    private let title: LocalizedStringKey
    private let isBusy: Bool
    private let action: () -> Void

    public init(_ title: LocalizedStringKey, isBusy: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isBusy = isBusy
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                Text(title).opacity(isBusy ? 0 : 1)
                if isBusy { ProgressView() }
            }
            .frame(maxWidth: .infinity, minHeight: HitTarget.standard)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .disabled(isBusy)
        .accessibilityValue(isBusy ? Text("In progress") : Text(""))
    }
}
