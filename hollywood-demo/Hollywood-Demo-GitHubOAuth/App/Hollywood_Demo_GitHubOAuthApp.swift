import SwiftUI

import Hollywood

@main @MainActor
struct Hollywood_Demo_GitHubOAuthApp: App {

    @State
    private var contextualActor = ContextualActor<AppContext>()

    var body: some Scene {
        WindowGroup {
            switch contextualActor.state {
            case .ready:
                WelcomeView(contextualActor: contextualActor)
            case .busy:
                ProgressView()
            case .success(let appContext):
                TokenContextFormView(tokenContext: appContext.tokenContext)
                    .navigationTitle("Token Context")
                    .toolbar {
                        Button("Sign Out") {
                            contextualActor.cancel()
                        }
                    }
            case .failure(let error, _):
                Text(error.localizedDescription)
            }
        }
    }
}
