import SwiftUI

struct WelcomeForm: View {

    let signIn: () -> Void

    var body: some View {
        GeometryReader { context in
            ZStack {
                VStack {
                    Text("Welcome To The GitHub OAuth Demo")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .foregroundStyle(.regularMaterial)

                    Button {
                        signIn()
                    } label: {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)

                    Color.clear.frame(height: 0)

                    HStack(spacing: 12) {
                        Button("Privacy") {
                            // TODO
                        }
                        Button("Support") {
                            // TODO
                        }
                    }
                    .font(.subheadline)
                }
                .frame(width: context.size.width * 0.8)
            }
            .frame(
                width: context.size.width,
                height: context.size.height,
                alignment: .center
            )
        }
    }
}

// MARK: Preview

struct WelcomeFormPreview: PreviewProvider {

    static var previews: some View {
        NavigationView {
            WelcomeForm(signIn: { })
        }
    }
}
