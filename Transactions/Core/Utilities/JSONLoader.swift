//
//  JSONLoader.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation
final class JSONLoader {
    static func load<T: Decodable>(_ filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("File not found")
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Decoding error: \(error)")
        }
    }
}


import Foundation

enum CurrencyFormatter {

    static func string(from amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formatted = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "$\(formatted)"
    }
}
