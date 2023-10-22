//
//  Data + Extension.swift
//  KeychainManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import Foundation

// MARK: - Decode Object from Data
extension Data {
    public func decode<T: Decodable>(to type: T.Type,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return try? decoder.decode(T.self, from: self)
    }
}
