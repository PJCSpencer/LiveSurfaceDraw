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
    
    @ObservedObject private(set) var item: PJCLiveSurfaceItem
    
    @State private(set) var projectSize: CGSize
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
                    Image(self.item.isHidden ? "eye.slash" : "eye") /* TODO:Discover switch ViewModifier to provide resource ... */
                        .resizable()
                        .frame(width: 22, height: 22)
                        .onTapGesture
                        { self.item.isHidden = !self.item.isHidden }
                    
                    Spacer()
                    
                    TextField("\(self.item.name)", text: self.$item.name)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(white: 0.2))
                        .fixedSize()
                    
                    Spacer().frame(width: 16)
                    
                    PJCLayerPreviewImage(item: self.item)
                        .frame(width: self.projectSize.width,
                               height: self.projectSize.height)
                    
                    Spacer().frame(width: 32)
                    
                }
                .frame(alignment: .trailing)
            }
            .frame(width: reader.size.width)
        }
    }
}

