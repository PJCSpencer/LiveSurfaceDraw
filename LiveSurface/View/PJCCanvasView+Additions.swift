//
//  PJCCanvasView+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


extension PJCCanvasView
{
    static func body(_ item: PJCLiveSurfaceItem) -> some View
    {
        Circle()
            .offset(item.geometry.origin)
            .fill(Color.gray)
            .frame(width: item.geometry.size.width,
                   height: item.geometry.size.height,
                   alignment: item.geometry.alignment)
    }
}

