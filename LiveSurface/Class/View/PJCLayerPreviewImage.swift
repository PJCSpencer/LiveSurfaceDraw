//
//  PJCLayerPreviewImage.swift
//  LiveSurface
//
//  Created by Peter Spencer on 07/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayerPreviewImage
{
    // MARK: - Property(s)
    
    @Binding var item: PJCLiveSurfaceItem
}

extension PJCLayerPreviewImage: View
{
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.blue.opacity(0.05))
            
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.blue.opacity(0.3))
            
            // TODO:Support path ...
        }
    }
}

