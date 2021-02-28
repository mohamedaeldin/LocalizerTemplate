//
//  AppDelegate.swift
//  LocalizerExample
//
//  Created by Mohamed Alaa El-Din on 28/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Localizer.setDefaultLanguage()
        Localizer.setupSwizzling()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

