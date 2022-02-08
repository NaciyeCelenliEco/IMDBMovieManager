//
//  AppDelegate.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        let rootController = NavigationController(rootViewController: LoginViewController())
        self.window?.rootViewController = rootController
      
        self.window?.makeKeyAndVisible();

        return true
    }




}

