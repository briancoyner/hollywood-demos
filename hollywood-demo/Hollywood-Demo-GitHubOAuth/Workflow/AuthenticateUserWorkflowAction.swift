import AuthenticationServices

import Hollywood

struct SomeError: Error {
}

struct AuthenticateUserWorkflowAction: WorkflowAction, @unchecked Sendable {

    let clientID: String
    let presentationContextProvider: any ASWebAuthenticationPresentationContextProviding

    @MainActor
    func execute() async throws -> AuthorizationCode {
        
        return try await withCheckedThrowingContinuation { continuation in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "github.com"
            components.path = "/login/oauth/authorize"
            components.queryItems = [
                URLQueryItem(name: "client_id", value: clientID)
            ]

            let session = makeSession(for: components.url!, continuation: continuation)
            
            session.presentationContextProvider = presentationContextProvider
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        }
    }
}

extension AuthenticateUserWorkflowAction {

    private func makeSession(for url: URL, continuation: CheckedContinuation<AuthorizationCode, any Error>) -> ASWebAuthenticationSession {

        return ASWebAuthenticationSession(url: url, callbackURLScheme: "authhub") { callbackURL, callbackError in

            switch (callbackURL, callbackError) {
            case (.none, .some(let error)):
                continuation.resume(throwing: error)
            case (.some(let resultURL), .none):

                let components = URLComponents(url: resultURL, resolvingAgainstBaseURL: false)
                let queryItems = components?.queryItems
                let accessToken = queryItems?
                    .first(where: { $0.name == "code" })?.value
                    .map { AuthorizationCode(value: $0) }

                guard let accessToken = accessToken else {
                    continuation.resume(throwing: SomeError())
                    return
                }

                continuation.resume(returning: accessToken)
            default:
                continuation.resume(throwing: SomeError())
            }
        }
    }
}
