import SwiftUI

import Hollywood

struct WelcomeView: View {

    let contextualActor: ContextualActor<AppContext>

    var body: some View {
        ZStack {
            WelcomeBackground()
            WelcomeForm(signIn: {
                contextualActor.execute(SignInUserWorkflowAction())
            })
        }
        .edgesIgnoringSafeArea(.all)
    }
}
