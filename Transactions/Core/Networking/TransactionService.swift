//
//  TransactionService.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() -> [Transaction]
}

final class TransactionService: TransactionServiceProtocol {
    func fetchTransactions() -> [Transaction] {
        let response: TransactionResponse = JSONLoader.load("transaction-list")
        return response.transactions
    }
}
