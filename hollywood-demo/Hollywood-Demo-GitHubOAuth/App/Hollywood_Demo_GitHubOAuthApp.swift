import SwiftUI

import Hollywood
import HollywoodUI

@main
struct Hollywood_Demo_GitHubOAuthApp: App {

    @StateObject
    private var contextualActor =  ContextualActor<AppContext>()

    var body: some Scene {
        WindowGroup {
            ContextualActorView(contextualActor: contextualActor) { state in
                switch state {
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
}
