import DesignSystem
import SwiftUI

/// HIG (Settings, Dark Mode): keep settings few, and don't duplicate system settings
/// such as appearance or text size. Link to the system Settings app instead.
struct SettingsView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    Button("Open System Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) { openURL(url) }
                    }
                }
                Section("Developer") {
                    NavigationLink("Design System") { DesignSystemCatalog() }
                }
                Section("About") {
                    LabeledContent("Version", value: Bundle.main.appVersion)
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Settings")
        }
    }
}

private extension Bundle {
    var appVersion: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}
