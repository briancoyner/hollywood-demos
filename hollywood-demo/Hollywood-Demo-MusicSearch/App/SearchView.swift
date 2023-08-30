import SwiftUI

import Hollywood

struct SearchView: View {

    @State
    private var contextualActor = ContextualActor<SearchResults>()

    @StateObject
    private var debounced = Debounced<String>(input: "", delay: .milliseconds(400))
}

extension SearchView {

    var body: some View {
        SearchResultListView(results: results(for: contextualActor.state))
            .searchable(text: $debounced.input, placement: .automatic, prompt: "Search")
            .onChange(of: debounced.output) { _, _ in
                contextualActor.execute(SearchMusicStoreWorkflowAction(searchTerm: debounced.output))
            }
        .navigationTitle("Music Search")
    }
}

extension SearchView {

    private func results(for state: ContextualActor<SearchResults>.State) -> [SearchResult] {
        switch state {
        case .ready:
            return []
        case .busy:
            return []
        case .success(let results):
            return results.results
        case .failure(_, _):
            return []
        }
    }
}
