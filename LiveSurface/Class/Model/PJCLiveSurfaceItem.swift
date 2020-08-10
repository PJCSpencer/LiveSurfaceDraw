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

class PJCLiveSurfaceItem: ObservableObject, Identifiable
{
    // MARK: - Constant(s)
    
    static let identity: PJCLiveSurfaceItem = PJCLiveSurfaceItem()
    
    
    // MARK: - Specifying the Identified Item
    
    var id = UUID()
    
    
    // MARK: - Property(s)
    
    @Published var index: Int
    
    @Published var name: String
    
    @Published var geometry: PJCGeometry
    
    let path: PJCLiveSurfaceItemPathProviderHandler
    
    @Published var isHidden: Bool = false

    
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
    
    init()
    {
        self.index = -1
        self.name = ""
        self.geometry = PJCGeometry()
        self.path = { (_) in Path() }
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

