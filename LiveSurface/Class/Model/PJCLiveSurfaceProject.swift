//
//  PJCLiveSurfaceProject.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


class PJCLiveSurfaceProject: PJCDelegateClass, ObservableObject
{
    // MARK: - Property(s)
    
    @Published var title: String = "Untitled Project"
    
    @Published private(set) var items: [PJCLiveSurfaceItem] = PJCLiveSurfaceItem.mocked // TODO:Support layer group(s) ...
    
    @Published var modtoolType: Int = 0
    
    
    // MARK: - Initialisation
    
    init()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1))
        { self.modtoolType = 7 }
    }
}

