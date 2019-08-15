//
//  AppDelegate.swift
//  RxSwiftArchitectureProgress
//
//  Created by Anton Nazarov on 01/07/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow()

    // swiftlint:disable:next discouraged_optional_collection
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window?.makeKeyAndVisible()
        let searchViewController = SearchViewController.instantiate().then {
            $0.viewModel = Dependencies.searchViewModel
        }
        window?.rootViewController = UINavigationController(rootViewController: searchViewController)
        return true
    }
}
