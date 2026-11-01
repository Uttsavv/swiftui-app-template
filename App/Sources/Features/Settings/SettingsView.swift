import DesignSystem
import SwiftUI

/// HIG (Settings, Dark Mode): keep settings few, and don't duplicate system settings
/// such as appearance or text size. Link to the system Settings app instead.
struct SettingsView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.theme) private var theme

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button("Open System Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) { openURL(url) }
                    }
                } header: { header("General") }
                Section {
                    NavigationLink("Design System") { DesignSystemCatalog() }
                } header: { header("Developer") }
                Section {
                    LabeledContent("Version") {
                        Text(Bundle.main.appVersion).foregroundStyle(theme.colors.textSecondary)
                    }
                } header: { header("About") }
            }
            .formStyle(.grouped)
            .navigationTitle("Settings")
        }
    }

    /// Section headers in the theme's secondary colour; the system default can fall below 4.5:1.
    private func header(_ title: LocalizedStringKey) -> some View {
        Text(title).foregroundStyle(theme.colors.textSecondary)
    }
}

private extension Bundle {
    var appVersion: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}
