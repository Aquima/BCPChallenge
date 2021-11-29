//
//  AplicationCoordinator.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow?
    let rootViewController: UINavigationController
    var homeCoordinator: HomeCoordinator
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.isHidden = true
        homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    func start() {
        window?.rootViewController = rootViewController
        homeCoordinator.start()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
