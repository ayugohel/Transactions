//
//  TransactionListViewModel.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation
final class TransactionListViewModel {

    private let service: TransactionServiceProtocol
    private(set) var transactions: [Transaction] = []

    init(service: TransactionServiceProtocol = TransactionService()) {
        self.service = service
    }

    func load() {
        transactions = service.fetchTransactions()
    }

    func numberOfRows() -> Int {
        transactions.count
    }

    func transaction(at index: Int) -> Transaction {
        transactions[index]
    }
}
