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
        item.path(item).fill(Color(white: 0.8)) // TODO:Extend to support styling ...
    }
}

