//
//  TooltipView.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation
import UIKit

final class TooltipView: UIView {

    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let summaryTextView = UITextView()
    private let expandedTextView = UITextView()

    private var expandedHeightConstraint: NSLayoutConstraint!
    private(set) var isExpanded = false

    private let summaryText = "Transactions are processed Monday to Friday (excluding holidays). "
    private let expandedText = "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day. "

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        render(animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        addSubview(containerView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: "speaker.wave.2")
        iconImageView.tintColor = UIColor.systemBrown
        iconImageView.contentMode = .scaleAspectFit

        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        summaryTextView.backgroundColor = .clear
        summaryTextView.isEditable = false
        summaryTextView.isScrollEnabled = false
        summaryTextView.isSelectable = true
        summaryTextView.delegate = self
        summaryTextView.textContainerInset = .zero
        summaryTextView.textContainer.lineFragmentPadding = 0
        summaryTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]

        expandedTextView.translatesAutoresizingMaskIntoConstraints = false
        expandedTextView.backgroundColor = .clear
        expandedTextView.isEditable = false
        expandedTextView.isScrollEnabled = false
        expandedTextView.isSelectable = true
        expandedTextView.delegate = self
        expandedTextView.textContainerInset = .zero
        expandedTextView.textContainer.lineFragmentPadding = 0
        expandedTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        expandedTextView.alpha = 0

        containerView.addSubview(iconImageView)
        containerView.addSubview(summaryTextView)
        containerView.addSubview(expandedTextView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),

            summaryTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            summaryTextView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 14),
            summaryTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            expandedTextView.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor, constant: 10),
            expandedTextView.leadingAnchor.constraint(equalTo: summaryTextView.leadingAnchor),
            expandedTextView.trailingAnchor.constraint(equalTo: summaryTextView.trailingAnchor),
            expandedTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])

        expandedHeightConstraint = expandedTextView.heightAnchor.constraint(equalToConstant: 0)
        expandedHeightConstraint.isActive = true
    }

    private func render(animated: Bool) {
        let summaryAction = isExpanded ? "" : "Show more"
        summaryTextView.attributedText = makeAttributedText(
            body: summaryText,
            action: summaryAction,
            actionURL: "action://expand"
        )

        let expandedAction = isExpanded ? "Show less" : ""
        expandedTextView.attributedText = makeAttributedText(
            body: expandedText,
            action: expandedAction,
            actionURL: "action://collapse"
        )

        if isExpanded {
            expandedHeightConstraint.isActive = false
        } else {
            expandedHeightConstraint.isActive = true
        }

        let changes = {
            self.expandedTextView.alpha = self.isExpanded ? 1 : 0
            self.superview?.layoutIfNeeded()
        }

        if animated {
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.curveEaseInOut, .beginFromCurrentState]
            ) {
                changes()
            }
        } else {
            changes()
        }
    }

    private func makeAttributedText(body: String, action: String, actionURL: String) -> NSAttributedString {
        let fullText = body + action

        let attributed = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .regular),
                .foregroundColor: UIColor.label
            ]
        )

        if !action.isEmpty {
            let actionRange = (fullText as NSString).range(of: action)
            attributed.addAttribute(.link, value: actionURL, range: actionRange)
        }

        return attributed
    }

    private func toggleExpanded() {
        isExpanded.toggle()
        render(animated: true)
    }
}

extension TooltipView: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        if URL.absoluteString == "action://expand" || URL.absoluteString == "action://collapse" {
            toggleExpanded()
            return false
        }
        return true
    }
}

//final class TooltipView: UIView {
//
//    private let containerView = UIView()
//    private let iconImageView = UIImageView()
//    private let summaryTextView = UITextView()
//    private let expandedLabel = UILabel()
//
//    private var expandedHeightConstraint: NSLayoutConstraint!
//    private(set) var isExpanded = false
//
//    private let summaryText = "Transactions are processed Monday to Friday (excluding holidays). "
//    private let expandedText = "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day."
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        render(animated: false)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .white
//        containerView.layer.cornerRadius = 12
//        containerView.layer.borderWidth = 1
//        containerView.layer.borderColor = UIColor.systemGray4.cgColor
//        addSubview(containerView)
//
//        iconImageView.translatesAutoresizingMaskIntoConstraints = false
//        iconImageView.image = UIImage(named: "buddy-tip-icon")
//        iconImageView.contentMode = .scaleAspectFit
//
//        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
//        summaryTextView.backgroundColor = .clear
//        summaryTextView.isEditable = false
//        summaryTextView.isScrollEnabled = false
//        summaryTextView.isSelectable = true
//        summaryTextView.delegate = self
//        summaryTextView.textContainerInset = .zero
//        summaryTextView.textContainer.lineFragmentPadding = 0
//        summaryTextView.linkTextAttributes = [
//            .foregroundColor: UIColor.systemBlue,
//            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
//        ]
//
//        expandedLabel.translatesAutoresizingMaskIntoConstraints = false
//        expandedLabel.font = .systemFont(ofSize: 15, weight: .regular)
//        expandedLabel.textColor = .label
//        expandedLabel.numberOfLines = 0
//        expandedLabel.text = expandedText
//        expandedLabel.alpha = 0
//
//        containerView.addSubview(iconImageView)
//        containerView.addSubview(summaryTextView)
//        containerView.addSubview(expandedLabel)
//
//        NSLayoutConstraint.activate([
//            containerView.topAnchor.constraint(equalTo: topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
//            iconImageView.widthAnchor.constraint(equalToConstant: 28),
//            iconImageView.heightAnchor.constraint(equalToConstant: 28),
//
//            summaryTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
//            summaryTextView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 14),
//            summaryTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//
//            expandedLabel.topAnchor.constraint(equalTo: summaryTextView.bottomAnchor, constant: 8),
//            expandedLabel.leadingAnchor.constraint(equalTo: summaryTextView.leadingAnchor),
//            expandedLabel.trailingAnchor.constraint(equalTo: summaryTextView.trailingAnchor),
//            expandedLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
//        ])
//
//        expandedHeightConstraint = expandedLabel.heightAnchor.constraint(equalToConstant: 0)
//        expandedHeightConstraint.isActive = true
//    }
//
//    private func render(animated: Bool) {
//        let actionText = isExpanded ? "Show less" : "Show more"
//        let fullText = summaryText + actionText
//
//        let attributed = NSMutableAttributedString(
//            string: fullText,
//            attributes: [
//                .font: UIFont.systemFont(ofSize: 15, weight: .regular),
//                .foregroundColor: UIColor.label
//            ]
//        )
//
//        let actionRange = (fullText as NSString).range(of: actionText)
//        attributed.addAttribute(.link, value: "action://toggle", range: actionRange)
//
//        summaryTextView.attributedText = attributed
//        summaryTextView.sizeToFit()
//        
//        if isExpanded {
//            expandedHeightConstraint.isActive = false
//        } else {
//            expandedHeightConstraint.isActive = true
//        }
//
//        let changes = {
//            self.expandedLabel.alpha = self.isExpanded ? 1 : 0
//            self.superview?.layoutIfNeeded()
//        }
//
//        if animated {
//            UIView.animate(
//                withDuration: 0.25,
//                delay: 0,
//                options: [.curveEaseInOut, .beginFromCurrentState]
//            ) {
//                changes()
//            }
//        } else {
//            changes()
//        }
//        
//    }
//
//    private func toggle() {
//        isExpanded.toggle()
//        render(animated: true)
//    }
//}
//
//extension TooltipView: UITextViewDelegate {
//    func textView(
//        _ textView: UITextView,
//        shouldInteractWith URL: URL,
//        in characterRange: NSRange,
//        interaction: UITextItemInteraction
//    ) -> Bool {
//        if URL.absoluteString == "action://toggle" {
//            toggle()
//            return false
//        }
//        return true
//    }
//}
