//
//  PJCLiveSurfaceProject+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 03/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


protocol PJCDelegateClass: class { /* Whatever. */ }

class PJCWeakDelegate
{
    private(set) weak var delegate: PJCDelegateClass?
    
    init(_ delegate: PJCDelegateClass)
    { self.delegate = delegate }
}

class PJCWeakLiveSurfaceProject
{
    private(set) weak var project: PJCLiveSurfaceProject?
    
    init(_ project: PJCLiveSurfaceProject)
    { self.project = project }
}

