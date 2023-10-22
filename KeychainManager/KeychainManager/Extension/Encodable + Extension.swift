//
//  Encodable + Extension.swift
//  KeychainManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import Foundation

public extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
