//
//  PJCTransformTool+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


typealias PJCTansform2DHandler = (_ geometry: PJCGeometry, _ drag: PJCTransformDrag) -> PJCGeometry

class PJCTransform2D
{
    static let table: [PJCControlPointPosition:PJCTansform2DHandler] =
    [
        .centre         : PJCTransforn2DTranslate.translate,
        
        .leftMiddle     : PJCTransforn2DScale.sizedX,
        .topMiddle      : PJCTransforn2DScale.sizedY,
        .rightMiddle    : PJCTransforn2DScale.sizedWidth,
        .bottomMiddle   : PJCTransforn2DScale.sizedHeight,
        
        .topLeft        : PJCTransforn2DScale.sizedTopLeft,
        .bottomLeft     : PJCTransforn2DScale.sizedBottomLeft,
        .topRight       : PJCTransforn2DScale.sizedTopRight,
        .bottomRight    : PJCTransforn2DScale.sizedBottomRight
    ]
}

class PJCTransforn2DTranslate
{
    static func translate(_ geometry: PJCGeometry,
                          _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let inset: CGPoint = drag.start - drag.anchor
        let pt: CGPoint = drag.location - inset
        
        return PJCGeometry(pt, size: geometry.size)
    }
}

class PJCTransforn2DScale
{
    // MARK: - Lateral Horizonatlly
    
    static func sizedX(_ geometry: PJCGeometry,
                       _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location.x - geometry.origin.x
        let width = PJCSelectionView.constrained(geometry.size.width - offset)
        
        var dx = geometry.origin.x + offset
        if width <= PJCSelectionView.minimumCombinedRadius
        { dx = geometry.origin.x + geometry.size.width - PJCSelectionView.minimumCombinedRadius }
        
        let pt = CGPoint(x: dx, y: geometry.origin.y)
        let size = CGSize(width: width, height: geometry.size.height)
        
        return PJCGeometry(pt, size: size)
    }
    
    static func sizedWidth(_ geometry: PJCGeometry,
                          _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let sized = PJCTransforn2DScale.sizedBottomRight(geometry, drag)
        let size = CGSize(width: sized.size.width,
                          height: geometry.size.height)
         
        return PJCGeometry(geometry.origin, size: size)
    }
    
    
    // MARK: - Lateral Vertically
    
    static func sizedY(_ geometry: PJCGeometry,
                       _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location.y - geometry.origin.y
        let height = PJCSelectionView.constrained(geometry.size.height - offset)
        
        var dy = geometry.origin.y + offset
        if height <= PJCSelectionView.minimumCombinedRadius
        { dy = geometry.origin.y + geometry.size.height - PJCSelectionView.minimumCombinedRadius }
        
        let pt = CGPoint(x: geometry.origin.x, y: dy)
        let size = CGSize(width: geometry.size.width, height: height)
        
        return PJCGeometry(pt, size: size)
    }
    
    static func sizedHeight(_ geometry: PJCGeometry,
                           _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let sized = PJCTransforn2DScale.sizedBottomRight(geometry, drag)
        let size = CGSize(width: geometry.size.width,
                          height: sized.size.height)
        
        return PJCGeometry(geometry.origin, size: size)
    }
    
    
    // MARK: - Corner(s)
    
    static func sizedTopRight(_ geometry: PJCGeometry,
                              _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location - (geometry.origin + (geometry.size * CGSize.unitWidth))
        let size = (geometry.size + (offset * CGPoint.unitYNegative)).greaterThan(PJCSelectionView.minimumCombinedRadius)
        var pt = geometry.origin + (offset * CGPoint.unitY)
        
        if size.height <= PJCSelectionView.minimumCombinedRadius
        { pt.y = geometry.origin.y + geometry.size.height - PJCSelectionView.minimumCombinedRadius }
        
        return PJCGeometry(pt, size: size)
    }
    
    static func sizedBottomRight(_ geometry: PJCGeometry,
                                 _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location - (geometry.origin + geometry.size)
        let size = (geometry.size + offset).greaterThan(PJCSelectionView.minimumCombinedRadius)
        
        return PJCGeometry(geometry.origin, size: size)
    }
    
    static func sizedTopLeft(_ geometry: PJCGeometry,
                             _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location - geometry.origin
        var pt = geometry.origin + offset
        let size = (geometry.size - offset).greaterThan(PJCSelectionView.minimumCombinedRadius)
        
        if size.height <= PJCSelectionView.minimumCombinedRadius
        { pt.y = geometry.origin.y + geometry.size.height - PJCSelectionView.minimumCombinedRadius }
        
        if size.width <= PJCSelectionView.minimumCombinedRadius
        {  pt.x = geometry.origin.x + geometry.size.width - PJCSelectionView.minimumCombinedRadius }
        
        return PJCGeometry(pt, size: size)
    }
    
    static func sizedBottomLeft(_ geometry: PJCGeometry,
                                _ drag: PJCTransformDrag) -> PJCGeometry
    {
        let offset = drag.location - (geometry.origin + (geometry.size * CGSize.unitHeight))
        var pt = geometry.origin + (offset * CGPoint.unitX)
        let size = (geometry.size + (offset * CGPoint.unitXNegative)).greaterThan(PJCSelectionView.minimumCombinedRadius)
        
        if size.width <= PJCSelectionView.minimumCombinedRadius
        {  pt.x = geometry.origin.x + geometry.size.width - PJCSelectionView.minimumCombinedRadius }
        
        return PJCGeometry(pt, size: size)
    }
}

