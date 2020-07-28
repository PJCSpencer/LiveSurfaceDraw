//
//  PJCLiveSurfaceViewController.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit
import SwiftUI


class PJCLiveSurfaceViewController: UIHostingController<PJCLiveSurfaceView>
{
    // MARK: - Initialisation
    
    init()
    { super.init(rootView: PJCLiveSurfaceView()) }
    
    
    // MARK: - Creating a Hosting Controller Object
    
    override init(rootView: PJCLiveSurfaceView)
    { super.init(rootView: rootView) }
    
    @objc required dynamic init?(coder aDecoder: NSCoder)
    { fatalError("init(coder:) has not been implemented") }
}

