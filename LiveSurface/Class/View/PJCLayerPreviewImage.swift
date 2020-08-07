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
    // MARK: - Constant(s)
    
    static let cornerRadius: CGFloat = 4
    
    
    // MARK: - Property(s)
    
    @Binding var item: PJCLiveSurfaceItem
}

extension PJCLayerPreviewImage: View
{
    var body: some View
    {
        let shape = RoundedRectangle(cornerRadius: PJCLayerPreviewImage.cornerRadius)
        
        return GeometryReader
        { reader in
            
            ZStack
                {
            shape.fill(Color.white)
            shape.fill(Color.blue.opacity(0.05))
            shape.stroke(Color.blue.opacity(0.3))
            
            self.item
                .path((self.item.geometry.size * 0.2).centered(in: reader.size))
                .fill(Color(white: 0.8))
                .clipShape(shape)
            }
        }
    }
}

