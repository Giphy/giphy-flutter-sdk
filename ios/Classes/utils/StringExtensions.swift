//
//  StringExtensions.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.2.2024.
//

import Foundation

extension String {
    func snakeCaseToCamelCase() -> String {
        let items = self.split(separator: "_")
        let camelCase = items.enumerated().map { index, piece in
            index == 0 ? String(piece) : piece.capitalized
        }.joined()
        return camelCase
    }
    
    func camelCaseToSnakeCase() -> String {
        let pattern = "([a-z0-9])([A-Z])"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        let snakeCase = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
        return snakeCase
    }
}
