import DesignSystem
import SwiftUI

struct HomeView: View {
    @Environment(\.theme) private var theme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.l) {
                    DSCard {
                        VStack(alignment: .leading, spacing: Spacing.s) {
                            Text("Welcome").dsFont(.title2).fontWeight(.semibold)
                            Text("Replace this screen with the app's first real feature. Keep the content layer solid and let bars and controls carry the glass.")
                                .dsFont(.body)
                                .foregroundStyle(theme.colors.textSecondary)
                        }
                    }
                    DSEmptyState(
                        "Nothing Here Yet",
                        systemImage: "tray",
                        message: "Content you add will appear here.",
                        actionTitle: "Add Item"
                    ) {}
                }
                .padding(Spacing.l)
            }
            .background(theme.colors.background)
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {}
                }
            }
        }
    }
}

#Preview {
    HomeView().theme(.app)
}
