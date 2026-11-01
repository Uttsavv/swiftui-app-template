import SwiftUI

/// Every token and component on one screen. Open it in a preview or from the app's
/// Settings tab to check colours, type and motion under different accessibility settings.
public struct DesignSystemCatalog: View {
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var expanded = false
    @State private var busy = false

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                colours
                typography
                components
                motion
            }
            .padding(Spacing.l)
        }
        .background(theme.colors.background)
        .navigationTitle("Design System")
    }

    private var colours: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            DSSectionHeader("Colours")
            let swatches: [(String, Color)] = [
                ("Background", theme.colors.background), ("Surface", theme.colors.surface),
                ("Raised", theme.colors.surfaceRaised), ("Text", theme.colors.textPrimary),
                ("Secondary", theme.colors.textSecondary), ("Accent", theme.colors.accent),
                ("Success", theme.colors.success), ("Warning", theme.colors.warning), ("Danger", theme.colors.danger),
            ]
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: Spacing.s)], spacing: Spacing.s) {
                ForEach(swatches, id: \.0) { name, color in
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        RoundedRectangle(cornerRadius: Radius.control)
                            .fill(color)
                            .frame(height: 48)
                            .overlay(RoundedRectangle(cornerRadius: Radius.control).strokeBorder(theme.colors.separator))
                        Text(name).dsFont(.caption).foregroundStyle(theme.colors.textSecondary)
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
    }

    private var typography: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            DSSectionHeader("Typography")
            ForEach(Array(TextRole.allCases.enumerated()), id: \.offset) { _, role in
                Text(verbatim: "\(role)").dsFont(role).foregroundStyle(theme.colors.textPrimary)
            }
        }
    }

    private var components: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            DSSectionHeader("Components")
            DSCard {
                VStack(alignment: .leading, spacing: Spacing.s) {
                    Text("Card").dsFont(.headline)
                    Text("Solid surface, fixed outer radius. The inner fill is concentric.")
                        .dsFont(.subheadline)
                        .foregroundStyle(theme.colors.textSecondary)
                    Text("Nested concentric fill")
                        .dsFont(.footnote)
                        .padding(Spacing.m)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .dsConcentricBackground(theme.colors.surfaceRaised)
                }
            }
            DSPrimaryButton("Primary action", isBusy: busy) { busy.toggle() }
            HStack {
                Button("Secondary") {}.buttonStyle(.bordered)
                Button("Delete", role: .destructive) {}.buttonStyle(.bordered)
            }
            DSStatusLabel("Saved", kind: .success)
            DSStatusLabel("Storage almost full", kind: .warning)
            DSStatusLabel("Couldn’t connect", kind: .danger)
            DSGlassCluster {
                DSIconButton("Search", systemImage: "magnifyingglass") {}
                DSIconButton("Share", systemImage: "square.and.arrow.up") {}
                DSIconButton("More", systemImage: "ellipsis") {}
            }
        }
    }

    private var motion: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            DSSectionHeader("Motion")
            Text(reduceMotion ? "Reduce Motion is on: fades only." : "Tap to see the standard motion token.")
                .dsFont(.footnote)
                .foregroundStyle(theme.colors.textSecondary)
            Button(expanded ? "Collapse" : "Expand") { expanded.toggle() }
                .buttonStyle(.bordered)
            if expanded {
                DSCard { Text("Arrived with .standard motion").dsFont(.body) }
                    .dsTransition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .dsAnimation(.standard, value: expanded)
    }
}

#Preview("Catalog") {
    NavigationStack { DesignSystemCatalog() }
}

#Preview("Catalog, accessibility XXL") {
    NavigationStack { DesignSystemCatalog() }
        .dynamicTypeSize(.accessibility3)
}
