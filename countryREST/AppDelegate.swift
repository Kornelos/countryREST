//
//  AppDelegate.swift
//  countryREST
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let viewController = ViewController()
        window?.rootViewController = navigationController(rootViewController: viewController)
        return true

    }



}

