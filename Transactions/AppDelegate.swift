//
//  AppDelegate.swift
//  Transactions
//
//  Created by Ayushi Gohel on 2026-03-23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window)

        self.window = window
        self.appCoordinator = coordinator

        coordinator.start()
        
//        //Initiate window
//        window = UIWindow.init(frame: UIScreen.main.bounds)
//
//        //Initiate View Controller
//        let vc = SplashVC.init(nibName: SplashVC.IDENTIFIER, bundle: nil)
//        let root = UINavigationController.init(rootViewController: vc)
//
//        root.navigationBar.isHidden = true
//        window?.rootViewController = root
//        window?.makeKeyAndVisible()
        
        return true
    }


}

