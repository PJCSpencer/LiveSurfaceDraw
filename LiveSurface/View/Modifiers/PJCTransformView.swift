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
    
    let item: PJCLiveSurfaceItem
    
    fileprivate var dash: [CGFloat] = [6]
    
    @State fileprivate var phase: CGFloat = 0
    
    
    // MARK: -
    
    var body: some View
    {
        Rectangle()
            .stroke(Color.blue,
                    style: StrokeStyle(lineWidth: 2.0,
                                       dash: self.dash,
                                       dashPhase: self.phase))
            .frame(width: self.item.geometry.size.width,
                   height: self.item.geometry.size.height,
                   alignment: self.item.geometry.alignment)
            .onAppear { self.phase -= 12 }
            .animation(Animation.linear.repeatForever(autoreverses: false).speed(0.5))
    }
    
    
    // MARK: -
    
    init(_ item: PJCLiveSurfaceItem)
    { self.item = item }
}

