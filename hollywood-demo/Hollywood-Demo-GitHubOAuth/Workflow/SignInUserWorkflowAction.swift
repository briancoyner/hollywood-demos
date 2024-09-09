import Foundation
import AuthenticationServices

import Hollywood

@MainActor
struct SignInUserWorkflowAction: CompositeWorkflowAction {

    @MainActor
    func execute() async throws -> AppContext {
        let presentationAnchor = WebAuthenticationSessionPresentationAnchor(window: findWindow())
        let gitHubApp = HackGitHubApp()
        let code = try await execute(AuthenticateUserWorkflowAction(
            clientID: gitHubApp.clientID,
            presentationContextProvider: presentationAnchor
        ))

        let tokenContext = try await execute(ObtainTokensWorkflowAction(gitHubApp: gitHubApp, code: code))
        return AppContext(tokenContext: tokenContext)
    }
}

extension SignInUserWorkflowAction {

    private func findWindow() -> UIWindow {
        let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        return windowScene.windows[0]
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding

private final class WebAuthenticationSessionPresentationAnchor: NSObject, ASWebAuthenticationPresentationContextProviding {

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return window
    }
}
