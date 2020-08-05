//
//  PJCModifierToolset.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import SwiftUI


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
    
    static func tool(_ tool: Int,
                     for item: PJCLiveSurfaceItem?) -> AnyView?
    {
        guard let item = item else
        { return nil }
        
        switch tool
        {
        case 7:
            return PJCModifierTool(item: item).asAnyView()
        default:
            return nil
        }
    }
}

