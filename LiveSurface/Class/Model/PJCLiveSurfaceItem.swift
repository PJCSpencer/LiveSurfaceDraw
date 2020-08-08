//
//  PJCLiveSurfaceItem.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


typealias PJCLiveSurfaceItemPathProviderHandler = (CGRect) -> Path

protocol PJCLiveSurfaceItemPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path
}

class PJCLiveSurfaceItem: Identifiable
{
    // MARK: - Specifying the Identified Item
    
    var id = UUID()
    
    
    // MARK: - Property(s)
    
    var index: Int
    
    var name: String
    
    var geometry: PJCGeometry
    
    let path: PJCLiveSurfaceItemPathProviderHandler
    
    var isHidden: Bool = false
    
    
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

extension PJCLiveSurfaceItem: Equatable
{
    static func == (lhs: PJCLiveSurfaceItem,
                    rhs: PJCLiveSurfaceItem) -> Bool
    {
        return lhs.index == rhs.index && lhs.name == rhs.name
    }
}

