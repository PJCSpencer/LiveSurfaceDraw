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
        .leftMiddle : { (geometry, dragLocation) in PJCGeometry() },
        .rightMiddle : { (geometry, dragLocation) in
            
            let dx = dragLocation.x - (geometry.origin.x + geometry.size.width)
            let size = CGSize(width: geometry.size.width + dx,
                              height: geometry.size.height)
            
            return PJCGeometry(geometry.origin,
                               size: size)
        }
    ]
}

