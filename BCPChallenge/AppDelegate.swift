//
//  BCPChallengeDelegate.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()
        return true
    }
}

