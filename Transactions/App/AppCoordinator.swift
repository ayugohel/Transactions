//
//  AppCoordinator.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let listVC = TransactionListViewController()
        let nav = UINavigationController(rootViewController: listVC)
        nav.navigationBar.prefersLargeTitles = false

        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

