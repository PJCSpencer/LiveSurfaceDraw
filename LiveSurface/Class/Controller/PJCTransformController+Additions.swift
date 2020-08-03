//
//  PJCTransformController+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


typealias PJCTansform2DHandler = (_ geometry: PJCGeometry, _ dragLocation: CGPoint) -> PJCGeometry

class PJCTransform2D
{
    static let table: [PJCControlPointPosition:PJCTansform2DHandler] =
    [
        .leftMiddle     : PJCTransforn2DScale.originWidth,
        .topMiddle      : PJCTransforn2DScale.originHeight,
        .rightMiddle    : PJCTransforn2DScale.sizeWidth,
        .bottomMiddle   : PJCTransforn2DScale.sizeHeight
    ]
}

class PJCTransforn2DScale
{
    static func originWidth(_ geometry: PJCGeometry,
                            _ dragLocation: CGPoint) -> PJCGeometry
    {
        let offset = dragLocation.x - geometry.origin.x
        let width = PJCSelectionView.constrained(geometry.size.width - offset)
        
        var dx = geometry.origin.x + offset
        if width <= PJCSelectionView.minimumCombinedRadius
        { dx = geometry.origin.x + geometry.size.width - PJCSelectionView.minimumCombinedRadius }
        
        let pt = CGPoint(x: dx, y: geometry.origin.y)
        let size = CGSize(width: width, height: geometry.size.height)
        
        return PJCGeometry(pt, size: size)
    }
    
    static func originHeight(_ geometry: PJCGeometry,
                             _ dragLocation: CGPoint) -> PJCGeometry
    {
        let offset = dragLocation.y - geometry.origin.y
        let height = PJCSelectionView.constrained(geometry.size.height - offset)
        
        var dy = geometry.origin.y + offset
        if height <= PJCSelectionView.minimumCombinedRadius
        { dy = geometry.origin.y + geometry.size.height - PJCSelectionView.minimumCombinedRadius }
        
        let pt = CGPoint(x: geometry.origin.x, y: dy)
        let size = CGSize(width: geometry.size.width, height: height)
        
        return PJCGeometry(pt, size: size)
    }
    
    static func sizeWidth(_ geometry: PJCGeometry,
                          _ dragLocation: CGPoint) -> PJCGeometry
    {
        let offset = dragLocation.x - (geometry.origin.x + geometry.size.width)
        let width = PJCSelectionView.constrained(geometry.size.width + offset)
        let size = CGSize(width: width, height: geometry.size.height)
         
        return PJCGeometry(geometry.origin, size: size)
    }
    
    static func sizeHeight(_ geometry: PJCGeometry,
                           _ dragLocation: CGPoint) -> PJCGeometry
    {
        let offset = dragLocation.y - (geometry.origin.y + geometry.size.height)
        let height = PJCSelectionView.constrained(geometry.size.height + offset)
        let size = CGSize(width: geometry.size.width, height: height)
         
        return PJCGeometry(geometry.origin, size: size)
    }
}

