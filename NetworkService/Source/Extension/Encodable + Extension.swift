//
//  Data + Extension.swift
//  NetworkService
//
//  Created by Александр Александрович on 20.10.2023.
//

import Foundation

public extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
