import Foundation

import Hollywood

struct ObtainTokensWorkflowAction: WorkflowAction {

    let gitHubApp: HackGitHubApp
    let code: AuthorizationCode

    func execute() async throws -> TokenContext {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "github.com"
        components.path = "/login/oauth/access_token"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: gitHubApp.clientID),
            URLQueryItem(name: "client_secret", value: gitHubApp.clientSecret),
            URLQueryItem(name: "code", value: code.value)
        ]
        
        let url = components.url!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(TokenContext.self, from: data)
    }
}
