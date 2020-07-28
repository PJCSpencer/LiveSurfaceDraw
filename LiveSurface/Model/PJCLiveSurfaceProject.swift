//
//  PJCLiveSurfaceProject.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


class PJCLiveSurfaceProject: ObservableObject
{
    // MARK: - Property(s)
    
    @Published var title: String = "Untitled Project"
    
    @Published private(set) var items: [PJCLiveSurfaceItem] = [] // PJCLiveSurfaceItem.mocked
    
    
    // MARK: -
    
    init()
    {
        for i in 1...10
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i))
            {
                let element = PJCLiveSurfaceItem.create(self.items.count)
                self.items.append(element)
            }
        }
    }
}

