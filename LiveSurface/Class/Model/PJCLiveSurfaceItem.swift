//
//  PJCLiveSurfaceItem.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


typealias PJCLiveSurfaceItemPathProviderHandler = (PJCLiveSurfaceItem) -> Path

protocol PJCLiveSurfaceItemPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path
}

class PJCLiveSurfaceItem: PJCDelegateClass, Identifiable
{
    // MARK: - Specifying the Identified Item
    
    var id = UUID()
    
    
    // MARK: - Property(s)
    
    var index: Int
    
    var name: String
    
    var geometry: PJCGeometry
    
    let path: PJCLiveSurfaceItemPathProviderHandler
    
    
    // MARK: - Initialisation
    
    init(_ index: Int,
         name: String,
         geometry: PJCGeometry,
         path: @escaping PJCLiveSurfaceItemPathProviderHandler)
    {
        self.index = index
        self.name = name
        self.geometry = geometry
        self.path = path
    }
}

extension PJCLiveSurfaceItem // TODO:Support protocol ...
{
    static let mocked: [PJCLiveSurfaceItem] = (0..<10).map({ index in
        
        PJCLiveSurfaceItem.create(index)
    })
    
    static func create(_ index: Int) -> PJCLiveSurfaceItem
    {
        let radius: CGFloat = 50.0
        let scaledRadius: CGFloat = radius * 2
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

