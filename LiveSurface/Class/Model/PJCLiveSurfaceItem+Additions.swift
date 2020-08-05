//
//  PJCLiveSurfaceItem+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 05/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import SwiftUI


class PJCLiveSurfaceItemSelection: ObservableObject
{
    @Published var item: PJCLiveSurfaceItem
    
    init(_ item: PJCLiveSurfaceItem)
    { self.item = item }
}

