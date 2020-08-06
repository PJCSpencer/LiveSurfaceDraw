//
//  PJCLayerPreview.swift
//  LiveSurface
//
//  Created by Peter Spencer on 02/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


let PJCLayerPreviewScale: CGFloat = 0.85

struct PJCLayerPreview: View
{
    @State private(set) var item: PJCLiveSurfaceItem
    
    @State var isSelected: Bool = false
    
    
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
                    Text(self.item.name)
                    Spacer(minLength: 12)
                    Rectangle().fill(Color.blue)
                        .frame(width: reader.size.height * PJCLayerPreviewScale,
                               height: reader.size.height * PJCLayerPreviewScale,
                               alignment: .bottom)
                    Spacer().frame(width: 32)
                }
            }
        }
    }
}

