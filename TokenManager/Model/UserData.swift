//
//  UserData.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

struct UserData: Decodable {
    let type, username, applicationName, clientID: String?
    let tokenType, accessToken: String?
    let expiresIn: Int?
    let state, scope: String?

    enum CodingKeys: String, CodingKey {
        case type, username
        case applicationName = "application_name"
        case clientID = "client_id"
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case state, scope
    }
}

