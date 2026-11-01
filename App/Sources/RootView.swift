import DesignSystem
import SwiftUI

/// Top-level navigation. A system `TabView` gets Liquid Glass, the floating tab bar,
/// the separate search tab and sidebar adaptation on iPad for free.
struct RootView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        TabView(selection: $model.selectedTab) {
            Tab("Home", systemImage: "house", value: .home) {
                HomeView()
            }
            Tab("Settings", systemImage: "gearshape", value: .settings) {
                SettingsView()
            }
            Tab(value: AppModel.Destination.search, role: .search) {
                SearchView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    RootView()
        .environment(AppModel())
        .theme(.app)
}
