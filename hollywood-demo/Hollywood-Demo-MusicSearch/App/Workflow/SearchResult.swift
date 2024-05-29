import Foundation

struct SearchResults: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable, Hashable {

    let artistName: String
    let artworkUrl100: String?
    let trackCensoredName: String?
}
