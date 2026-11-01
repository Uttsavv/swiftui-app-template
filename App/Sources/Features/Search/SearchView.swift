import DesignSystem
import SwiftUI

struct SearchView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        NavigationStack {
            List {
                if model.searchText.isEmpty {
                    DSEmptyState("Search", systemImage: "magnifyingglass", message: "Type to search.")
                        .listRowBackground(Color.clear)
                } else {
                    Text("Results for “\(model.searchText)”")
                }
            }
            .navigationTitle("Search")
            .searchable(text: $model.searchText, prompt: "Search")
        }
    }
}
