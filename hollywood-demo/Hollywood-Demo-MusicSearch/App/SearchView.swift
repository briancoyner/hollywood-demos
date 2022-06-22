//
//  ContentView.swift
//  Hollywood-Demo-MusicSearch
//
//  Created by Brian Coyner on 6/12/22.
//

import SwiftUI

import Hollywood
import HollywoodUI

struct SearchView: View {

    @StateObject
    private var contextualActor = ContextualActor<SearchResults>()

    @StateObject
    private var debounced = Debounced<String>(input: "", delay: .milliseconds(400))
}

extension SearchView {

    var body: some View {
        ContextualActorView(contextualActor: contextualActor) { (state: ContextualActor.State) in
            SearchResultListView(results: results(for: state))
                .searchable(text: $debounced.input, placement: .automatic, prompt: "Search")
                .task(id: debounced.output, priority: .userInitiated, {
                    print("**** \(debounced.input); \(debounced.output)")
                    contextualActor.execute(SearchMusicStoreWorkflowAction(searchTerm: debounced.output))
                })
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
