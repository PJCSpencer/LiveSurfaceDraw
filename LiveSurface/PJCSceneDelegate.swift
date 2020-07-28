//
//  PJCSceneDelegate.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit
import SwiftUI


class PJCSceneDelegate: UIResponder, UIWindowSceneDelegate
{
    // MARK: - Property(s)
    
    var window: UIWindow?


    // MARK: - Connecting and Disconnecting the Scene
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else
        { return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = PJCLiveSurfaceViewController()
        self.window?.makeKeyAndVisible()
    }
}

