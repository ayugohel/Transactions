//
//  TransactionDetailViewModel.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation

final class TransactionDetailViewModel {
    let transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var isCredit: Bool {
        transaction.transactionType == .credit
    }

    var titleText: String {
        isCredit ? "Credit transaction" : "Debit transaction"
    }

    var fromText: String {
        "\(transaction.fromAccount) (\(last4Digits))"
    }

    var amountText: String {
        CurrencyFormatter.string(from: transaction.amount.value)
    }

    private var last4Digits: String {
        let digits = transaction.fromCardNumber.filter(\.isNumber)
        return String(digits.suffix(4))
    }
}

