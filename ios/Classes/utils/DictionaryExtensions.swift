//
//  DictionaryExtensions.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 26.2.2024.
//

import Foundation

extension Dictionary where Key == String, Value == Any? {
    func convertingKeys(_ direction: ConversionDirection, replacements: [String: String]? = nil) -> [String: Any?] {
        var newDictionary: [String: Any?] = [:]

        for (key, value) in self {
            var newKey: String
            switch direction {
            case .camelToSnake:
                newKey = key.camelCaseToSnakeCase()
            case .snakeToCamel:
                newKey = key.snakeCaseToCamelCase()
            }
            
            if let replacements = replacements {
                for (keyToReplace, key) in replacements  {
                    if keyToReplace == newKey {
                        newKey = key
                    }
                }
            }

            if let value = value {
                switch value {
                case let valueDictionary as [String: Any?]:
                    newDictionary[newKey] = valueDictionary.convertingKeys(direction, replacements: replacements)
                case let valueArray as [[String: Any?]]:
                    newDictionary[newKey] = valueArray.map { $0.convertingKeys(direction, replacements: replacements) }
                default:
                    newDictionary[newKey] = value
                }
            } else {                
                newDictionary[newKey] = nil
            }
        }

        return newDictionary
    }
}

enum ConversionDirection {
    case camelToSnake
    case snakeToCamel
}
