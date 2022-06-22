import Foundation
import AuthenticationServices

struct TokenContext: Decodable, Sendable {
    
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let refreshTokenExpiresIn: Int
    let scope: String
}
