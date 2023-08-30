import Foundation

import Hollywood

struct SearchMusicStoreWorkflowAction: WorkflowAction {

    let searchTerm: String

    func execute() async throws -> SearchResults {
        guard !searchTerm.isEmpty else {
            return SearchResults(results: [])
        }

        let encoded = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let url = URL(string: "https://itunes.apple.com/search?term=\(encoded)")!

        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        return try decoder.decode(SearchResults.self, from: data)
    }
}
