//
//  PJCLayerPreview.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


let PJCLayerPreviewScale: CGFloat = 0.85 // NB:This will probably be removed.

struct PJCLayerPreview
{
    // MARK: - Property(s)
    
    @State private(set) var item: PJCLiveSurfaceItem
    
    @State private(set) var isHidden: Bool = false
    
    // isSelected: Bool
    
    // previewImageSize: CGSize
}

extension PJCLayerPreview: View
{
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
                    Image(self.isHidden ? "LayerHide" : "LayerShow") /* TODO:Discover switch ViewModifier to provide resource ... */
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture
                        {
                            self.isHidden = !self.isHidden
                            self.item.isHidden = self.isHidden
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

