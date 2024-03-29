import SwiftUI

import Hollywood

struct SearchResultListView: View {

    let results: [SearchResult]

    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                HStack(alignment: .top, spacing: 8) {

                    // Similar to the AsyncImage API but uses the Hollywood APIs as an example/ demo.
                    HollywoodImage(url: URL(string: result.artworkUrl100)!)

                    VStack(alignment: .leading) {
                        Text(result.artistName)
                            .font(.headline)

                        Text(result.trackCensoredName)
                            .font(.subheadline)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
