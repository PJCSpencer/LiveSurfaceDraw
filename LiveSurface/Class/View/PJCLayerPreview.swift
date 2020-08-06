//
//  PJCLayerPreview.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


let PJCLayerPreviewScale: CGFloat = 0.85 // NB:This will probably be removed.

struct PJCLayerPreview: View
{
    // MARK: - Property(s)
    
    @State private(set) var item: PJCLiveSurfaceItem
    
    // isSelected: Bool
    
    // previewImageSize: CGSize
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        GeometryReader
        { reader in
            
            ZStack
            {
                Rectangle()
                    .fill(Color.white.opacity(PJCHiddenButResponsiveOpacity))
                
                HStack
                {
                    Button(action: { /* TODO: */ })
                    {
                        Image("LayerShow")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                    
                    Spacer()
                    
                    Text(self.item.name)
                        .frame(alignment: .trailing)
                        .font(.system(size: 18))
                        .foregroundColor(Color(white: 0.2))
                    
                    Spacer().frame(width: 16)
                    
                    PJCLayerPreviewImage(item: self.$item)
                        .frame(width: reader.size.height * (PJCLayerPreviewScale * 1.4), /* TODO:Resolve ... */
                               height: reader.size.height * PJCLayerPreviewScale,
                               alignment: .bottom)
                    
                    Spacer().frame(width: 32)
                    
                }.frame(alignment: .trailing)
            }.frame(width: reader.size.width)
        }
    }
}

struct PJCLayerPreviewImage: View
{
    // MARK: - Property(s)
    
    @Binding var item: PJCLiveSurfaceItem
    
    
    // MARK: - Implementing a Custom View
    
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

