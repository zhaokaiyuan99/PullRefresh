//
//  AppDelegate.swift
//  PullRefresh
//
//  Created by SunSet on 14-6-25.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        let mainViewController = RootViewController(nibName:nil,  bundle: nil)
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        
        self.window!.rootViewController = navigationViewController
        self.window!.makeKeyAndVisible()
        return true
    }
}

