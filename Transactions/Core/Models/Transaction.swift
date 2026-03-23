//
//  Transaction.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation

import Foundation

struct TransactionResponse: Decodable {
    let transactions: [Transaction]
}

struct Transaction: Decodable {
    let key: String
    let transactionType: TransactionType
    let merchantName: String
    let amount: Amount
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String

    enum CodingKeys: String, CodingKey {
        case key
        case transactionType = "transaction_type"
        case merchantName = "merchant_name"
        case amount
        case postedDate = "posted_date"
        case fromAccount = "from_account"
        case fromCardNumber = "from_card_number"
    }
}

enum TransactionType: String, Decodable {
    case credit = "CREDIT"
    case debit = "DEBIT"
}


// MARK: Amount Value
struct Amount: Decodable {
    let value: Double
    let currency: String
}
