//
//  TransactionListViewController.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import UIKit
import Foundation

final class TransactionListViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let viewModel = TransactionListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transactions"
        view.backgroundColor = .systemBackground
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.tableFooterView = UIView()

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadData() {
        viewModel.load()
        tableView.reloadData()
    }
}

extension TransactionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionCell.reuseIdentifier,
            for: indexPath
        ) as! TransactionCell

        let transaction = viewModel.transaction(at: indexPath.row)
        cell.configure(with: transaction)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = viewModel.transaction(at: indexPath.row)
        let detailVC = TransactionDetailViewController(transaction: transaction)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
