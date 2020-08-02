//
//  PJCLayerPreview.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayerPreview: View
{
    @State private(set) var item: PJCLiveSurfaceItem
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        HStack
        {
            Text(self.item.name)
            
        }.background(Color(white: 0.95))
    }
}

