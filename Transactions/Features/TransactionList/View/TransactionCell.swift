//
//  TransactionCell.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import UIKit

final class TransactionCell: UITableViewCell {

    static let reuseIdentifier = "TransactionCell"

    private let merchantLabel = UILabel()
    private let amountLabel = UILabel()
    private let horizontalStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        accessoryType = .disclosureIndicator
        selectionStyle = .default

        merchantLabel.translatesAutoresizingMaskIntoConstraints = false
        merchantLabel.font = .systemFont(ofSize: 17, weight: .regular)
        merchantLabel.textColor = .label
        merchantLabel.numberOfLines = 0
        merchantLabel.lineBreakMode = .byWordWrapping

        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        amountLabel.textColor = .label
        amountLabel.textAlignment = .right
        amountLabel.numberOfLines = 1

        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        merchantLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        merchantLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .top
        horizontalStack.spacing = 12

        horizontalStack.addArrangedSubview(merchantLabel)
        horizontalStack.addArrangedSubview(amountLabel)

        contentView.addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            amountLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 72)
        ])
    }

    func configure(with transaction: Transaction) {
        merchantLabel.text = transaction.merchantName
        amountLabel.text = CurrencyFormatter.string(from: transaction.amount.value)
    }
}
