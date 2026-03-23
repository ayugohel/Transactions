//
//  TransactionDetailViewController.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import UIKit
import Foundation

final class TransactionDetailViewController: UIViewController {

    private let viewModel: TransactionDetailViewModel

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let cardView = UIView()

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    private let fromTitleLabel = UILabel()
    private let fromValueLabel = UILabel()
    private let amountTitleLabel = UILabel()
    private let amountValueLabel = UILabel()

    private let dividerView = UIView()
    private let tooltipView = TooltipView()
    private let closeButton = UIButton(type: .system)

    init(transaction: Transaction) {
        self.viewModel = TransactionDetailViewModel(transaction: transaction)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.systemGray6
        title = "Transaction Details"

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false

        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 5 //radious
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.systemGray4.cgColor

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        setupCardContents()
    }

    private func setupCardContents() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        fromTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fromValueLabel.translatesAutoresizingMaskIntoConstraints = false
        amountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        tooltipView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label

        fromTitleLabel.text = "From"
        fromTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        fromTitleLabel.textColor = .secondaryLabel

        fromValueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        fromValueLabel.textColor = .label
        fromValueLabel.numberOfLines = 0

        amountTitleLabel.text = "Amount"
        amountTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        amountTitleLabel.textColor = .secondaryLabel

        amountValueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        amountValueLabel.textColor = .label

        dividerView.backgroundColor = .systemGray4

        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        closeButton.backgroundColor = .systemRed
        closeButton.layer.cornerRadius = 14
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        cardView.addSubview(iconImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(fromTitleLabel)
        cardView.addSubview(fromValueLabel)
        cardView.addSubview(dividerView)
        cardView.addSubview(amountTitleLabel)
        cardView.addSubview(amountValueLabel)
        cardView.addSubview(tooltipView)
        cardView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40),
            iconImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            
            fromTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 56),
            fromTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            fromTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            fromValueLabel.topAnchor.constraint(equalTo: fromTitleLabel.bottomAnchor, constant: 12),
            fromValueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            fromValueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            dividerView.topAnchor.constraint(equalTo: fromValueLabel.bottomAnchor, constant: 28),
            dividerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            dividerView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            amountTitleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 28),
            amountTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            amountTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            amountValueLabel.topAnchor.constraint(equalTo: amountTitleLabel.bottomAnchor, constant: 12),
            amountValueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            amountValueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            tooltipView.topAnchor.constraint(equalTo: amountValueLabel.bottomAnchor, constant: 40),
            tooltipView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            tooltipView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            closeButton.topAnchor.constraint(equalTo: tooltipView.bottomAnchor, constant: 40),
            closeButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 56),
            closeButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -32)
        ])
    }

    private func configure() {
        // Title (Credit / Debit)
        titleLabel.text = viewModel.titleText

        // From (Momentum Regular Visa (8012))
        fromValueLabel.text = viewModel.fromText

        // Amount ($200.20)
        amountValueLabel.text = viewModel.amountText

        // Color based on type
        let color: UIColor = viewModel.isCredit ? .systemGreen : .systemRed
        let image = UIImage(named: "success-icon")?.withTintColor(color)

        // Icon (checkmark)
        iconImageView.image = image //UIImage(named: "success-icon")
        iconImageView.contentMode = .scaleAspectFit

    }

    @objc private func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
}
