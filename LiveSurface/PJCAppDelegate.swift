//
//  PJCAppDelegate.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


@UIApplicationMain
class PJCAppDelegate: UIResponder, UIApplicationDelegate
{
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 0,
                                                               left: 0,
                                                               bottom: 0,
                                                               right: 0)
        
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
}

