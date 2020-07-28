//
//  PJCLiveSurfaceItem.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


class PJCLiveSurfaceItem: Identifiable
{
    // MARK: - Specifying the Identified Item
    
    var id = UUID()
    
    
    // MARK: - Property(s)
    
    var index: Int
    
    var name: String
    
    let geometry: PJCGeometry
    
    
    // MARK: - Initialisation
    
    init(_ index: Int,
         name: String,
         geometry: PJCGeometry)
    {
        self.index = index
        self.name = name
        self.geometry = geometry
    }
}

extension PJCLiveSurfaceItem // TODO:Support protocol ...
{
    static let mocked: [PJCLiveSurfaceItem] = (0..<10).map({ index in
        
        let radius: CGFloat = 50.0
        let scaledRadius: CGFloat = radius * 0.5
        let width = UIScreen.main.bounds.width - radius
        let height = UIScreen.main.bounds.height - radius
        let pt = CGPoint(x: CGFloat.random(in: scaledRadius..<width),
                         y: CGFloat.random(in: scaledRadius..<height))
        let size = CGSize(width: radius,
                          height: radius)
        
        let geometry = PJCGeometry(pt,
                                   size: size)
        
        return PJCLiveSurfaceItem(index,
                                  name: "Untitled_\(index)",
                                  geometry: geometry)
    })
}

