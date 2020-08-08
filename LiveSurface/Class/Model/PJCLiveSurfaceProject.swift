//
//  PJCLiveSurfaceProject.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import UIKit


class PJCLiveSurfaceProject: PJCDelegateClass, ObservableObject
{
    // MARK: - Property(s)
    
    @Published var title: String = "Untitled Project"
    
    @Published var size: CGSize = UIScreen.main.bounds.size
    
    @Published private(set) var items: [PJCLiveSurfaceItem] = PJCLiveSurfaceItem.mocked // TODO:Support layer group(s) ...
    
    @Published var modtoolType: Int = 0 // TODO:Support abstraction ...
    
    
    // MARK: - Initialisation
    
    init()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1))
        { self.modtoolType = 7 }
    }
}

extension PJCLiveSurfaceProject
{
    func add()
    { 
        let element = PJCLiveSurfaceItem.create(self.items.count)
        self.items.append(element)
    }
}

extension PJCLiveSurfaceProject
{
    func share()
    { print("\(self)::\(#function)") }
}

