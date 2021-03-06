//
//  PJCGeometry.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit
import SwiftUI


struct PJCGeometry // TODO:Should this be a struct ..?
{
    // MARK: - Property(s)
    
    var origin: CGPoint
    
    var size: CGSize
    
    var alignment: Alignment = .center
    
    
    // MARK: - Initialisation
    
    init(_ origin: CGPoint,
         size: CGSize)
    {
        self.origin = origin
        self.size = size
    }
    
    init()
    {
        self.origin = .zero
        self.size = .zero
    }
}

extension PJCGeometry
{
    static var identity: PJCGeometry
    { return PJCGeometry() }
    
    var rect: CGRect
    { return CGRect(origin: self.origin, size: self.size) }
}

