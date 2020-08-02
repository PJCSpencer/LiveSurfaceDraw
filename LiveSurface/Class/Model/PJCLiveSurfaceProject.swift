//
//  PJCLiveSurfaceProject.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import SwiftUI


enum PJCModifierToolset
{
    case none
    case select
    case transform
}

class PJCLiveSurfaceProject: PJCDelegateClass, ObservableObject
{
    // MARK: - Property(s)
    
    @Published var title: String = "Untitled Project"
    
    @Published private(set) var items: [PJCLiveSurfaceItem] = PJCLiveSurfaceItem.mocked // TODO:Support layer group(s) ...
    
    @Published private(set) var modifier: PJCModifierProvider2?
    
    @Published var modtoolType: Int = 0
    
    
    // MARK: - Initialisation
    
    init()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1))
        {
            /*let count: Int = Int.random(in: 0..<self.items.count)
            
            guard let _ = self.items[count] as PJCLiveSurfaceItem? else
            { return }
            
            self.modifier = PJCTransformTool(item)*/
            
            self.modtoolType = 7
        }
        
        /*for i in 1...10
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i))
            {
                let element = PJCLiveSurfaceItem.create(self.items.count)
                self.items.append(element)
            }
        }*/
    }
}

class Toolset
{
    static var availableToolsetTypes: [Int]
    {
        return [0, 7]
    }
    
    static func tool(_ project: PJCLiveSurfaceProject) -> AnyView?
    {
        let count: Int = Int.random(in: 0..<project.items.count)
        
        if project.modtoolType == 7,
            let item = project.items[count] as PJCLiveSurfaceItem?
        {
            return ModTool(fixedGeometry: item.geometry).asAnyView()
        }
        return nil
    }
}

