//
//  PJCLiveSurfaceItem+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 05/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import SwiftUI


extension PJCLiveSurfaceItem // TODO:Support protocol ...
{
    static let mocked: [PJCLiveSurfaceItem] = (0..<10).map({ index in
        
        PJCLiveSurfaceItem.create(index)
    })
    
    static func create(_ index: Int) -> PJCLiveSurfaceItem
    {
        let radius: CGFloat = 50.0
        let scaledRadius: CGFloat = radius * CGFloat.random(in: 1...4.0)
        let width = (UIScreen.main.bounds.width * 1) - scaledRadius
        let height = (UIScreen.main.bounds.height * 0.85) - scaledRadius
        let pt = CGPoint(x: CGFloat.random(in: radius..<width),
                         y: CGFloat.random(in: radius..<height))
        let size = CGSize(width: scaledRadius,
                          height: scaledRadius)
        
        let geometry = PJCGeometry(pt,
                                   size: size)
        
        return PJCLiveSurfaceItem(index,
                                  name: "Untitled_\(index)",
                                  geometry: geometry,
                                  path: PJCSimpleShapes.random())
    }
}

class PJCLiveSurfaceItemSelection: ObservableObject // TODO:
{
    @Published var item: PJCLiveSurfaceItem
    
    init(_ item: PJCLiveSurfaceItem)
    { self.item = item }
}

