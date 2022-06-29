//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.accessibilityNavigationStyle = .automatic
        self.window?.rootViewController = OpenTVShow.startModuleWith()
        self.window?.makeKeyAndVisible()
        return true
    }


}

