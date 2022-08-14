//
//  UserDefaultsServices.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode([T].self, from: data).first
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode([newValue])

            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

// swiftlint:disable all
enum AppData {
    
    @Storage(key: Constants.DefaultsConstants.latestRequestTime, defaultValue: nil)
    static var latestRequestTime: Date?
    
}
