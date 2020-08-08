//
//  PJCLayerPreview.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayerPreview
{
    // MARK: - Property(s)
    
    @State private(set) var item: PJCLiveSurfaceItem
    
    @State private(set) var projectSize: CGSize
    
    @State private(set) var isHidden: Bool = false
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
                    Image(self.isHidden ? "eye.slash" : "LayerShow") /* TODO:Discover switch ViewModifier to provide resource ... */
                        .resizable()
                        .frame(width: 22, height: 22)
                        .onTapGesture
                        {
                            self.isHidden = !self.isHidden
                            self.item.isHidden = self.isHidden
                        }
                    
                    Spacer()
                    
                    Text(self.item.name)
                        .frame(alignment: .trailing)
                        .font(.system(size: 16))
                        .foregroundColor(Color(white: 0.2))
                    
                    Spacer().frame(width: 16)
                    
                    PJCLayerPreviewImage(item: self.$item)
                        .frame(width: self.projectSize.width,
                               height: self.projectSize.height)
                    
                    Spacer().frame(width: 32)
                    
                }.frame(alignment: .trailing)
            }.frame(width: reader.size.width)
        }
    }
}

