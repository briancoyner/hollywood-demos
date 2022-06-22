import SwiftUI

struct WelcomeBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                .mint,
                .orange,
                .blue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(.ultraThinMaterial)
    }
}

struct WelcomeBackground_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeBackground()
    }
}
