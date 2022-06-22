import SwiftUI

struct TokenContextFormView: View {

    let tokenContext: TokenContext

    var body: some View {
        Form {
            Section("Access Token") {
                Text(tokenContext.accessToken)
                Text(tokenContext.expiresIn.formatted())
            }

            Section("Refresh Token") {
                Text(tokenContext.refreshToken)
                Text(tokenContext.refreshTokenExpiresIn.formatted())
            }
        }
    }
}
