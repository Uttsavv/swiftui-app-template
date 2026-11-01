import DesignSystem
import SwiftUI

@main
struct AppTemplateApp: App {
    @State private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(model)
                .theme(.app)
        }
    }
}

extension Theme {
    /// The app's theme. Fill in the palette, typography and motion agreed in docs/design-brief.md.
    static let app = Theme(palette: .placeholder, typography: .init(), motion: .calm)
}
