//
//  PJCModifierToolset.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import SwiftUI


protocol PJCModifierProvider2
{
    // var project: PJCLiveSurfaceProject? { get }
    
    // init(_ project: PJCLiveSurfaceProject)
    
    // var cache: [?]
    
    func body() -> AnyView
}

protocol PJCModifierProvider
{
    // init(_ binding: Binding<PJCLiveSurfaceItem?>)
    
    // @Binding var binding: PJCLiveSurfaceItem?
    
    init?(_ item: PJCLiveSurfaceItem?)
    
    func body(/*to selection: PJCLiveSurfaceItem?*/) -> AnyView
}

enum PJCModifierToolset
{
    case none
    case select
    case transform
}

class PJCModifierTools
{
    
}

class Toolset // TODO:Support protocol ...
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
            return PJCModifierTool(fixedGeometry: item.geometry).asAnyView()
        }
        return nil
    }
}

