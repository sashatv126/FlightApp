//
//  KeychainManager.swift
//  KeychainManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import Foundation
import Security

public protocol KeychainManagerProtocol {
    associatedtype Key: KeychainKey
    /// Save value in keychain by key
    /// - Parameters:
    ///   - value: The value that we will save
    ///   - key: Key to value in keychain
    func saveValue<Object: Encodable>(value: Object, by key: Key) throws

    /// Load value from keychain by key
    /// - Parameter key: Key to value
    /// - Returns: return value
    func loadValue<Object: Decodable>(by key: Key, as: Object.Type) -> Object?

    /// Remove value from keychain by key
    /// - Parameter key: Key to value
    func removeValue(key: Key) throws

    /// Remove all values
    func removeAllValues() throws
}

public class KeychainManager<Key: KeychainKey>: KeychainManagerProtocol {
    public typealias Key = Key
    // MARK: - Set data

    public init() {}

    public func saveValue<Object: Encodable>(value: Object, by key: Key) throws {
        guard let data = value.toData() else { throw KeychainError.emptyData }
        do {
            try setData(data: data, key: key)
        } catch {
            throw error
        }
    }

    // MARK: - Get data
    public func loadValue<Object: Decodable>(by key: Key, as: Object.Type) -> Object? {
        guard let data = getData(by: key) else {
            return nil
        }
        return data.decode(to: Object.self)
    }

    // MARK: - Remove data
    public func removeValue(key: Key) throws {
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: key.rawValue] as [CFString: Any] as CFDictionary
        let status = SecItemDelete(query)
        if status != noErr {
            throw KeychainError.genericError(status: status)
        }
    }

    public func removeAllValues() throws {
        let query = [kSecClass: kSecClassGenericPassword] as [CFString: Any] as CFDictionary
        let status = SecItemDelete(query)
        if status != noErr {
            throw KeychainError.genericError(status: status)
        }
    }
}

// MARK: - Private methods
extension KeychainManager {
    /// Get data from KeyChain by key
    /// - Parameter key: Key to search in Keychain
    /// - Returns: value in format Data
    private func getData(by key: Key) -> Data? {
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: key.rawValue,
                kSecReturnData: true,
                kSecMatchLimit: kSecMatchLimitOne] as [CFString: Any] as CFDictionary
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        guard status == noErr, dataTypeRef != nil else { return nil }
        return dataTypeRef as? Data
    }

    /// Set data to keychain by key
    /// - Parameters:
    ///   - data: value in format Data
    ///   - key: Key to search in Keychain
    func setData(data: Data?, key: Key) throws {
        guard let data = data else { throw KeychainError.emptyData }
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: key.rawValue,
                 kSecValueData: data] as [CFString: Any] as CFDictionary
        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
        if status != noErr {
            throw KeychainError.genericError(status: status)
        }
    }
}

// MARK: - Enums
enum KeychainError: Error {
    case emptyData
    case genericError(status: OSStatus)
}

public protocol KeychainKey {
    var rawValue: String { get }
}
