//
//  PJCTransformView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCTransformView: View
{
    // MARK: - Property(s)
    
    @Binding var item: PJCLiveSurfaceItem?
    
    fileprivate var dash: [CGFloat] = [6]
    
    @State fileprivate var phase: CGFloat = 0
    
    
    // MARK: -
    
    var body: some View
    {
        Rectangle()
            .offset(self.item?.geometry.origin ?? .zero)
            .stroke(Color.blue,
                    style: StrokeStyle(lineWidth: 2.0,
                                       dash: self.dash,
                                       dashPhase: self.phase))
            .frame(width: self.item?.geometry.size.width ?? 0,
                   height: self.item?.geometry.size.height ?? 0,
                   alignment: self.item?.geometry.alignment ?? .center)
            /*.onAppear { self.phase -= 12 }
            .animation(Animation.linear.repeatForever(autoreverses: false).speed(0.5))*/
    }
    
    init(item: Binding<PJCLiveSurfaceItem?>)
    { self._item = item }
}

