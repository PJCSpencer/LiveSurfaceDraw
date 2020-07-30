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
    
    fileprivate var gesture: some Gesture // TODO:Needs to be refactored to support gesture sequencing ...
    {
        DragGesture()
            .onChanged { value in }
            .onEnded { _ in }
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        Rectangle().selected(self.item?.geometry.rect ?? .zero)
        
        /*ZStack()
        {
            Rectangle()
                .offset(self.item?.geometry.origin ?? .zero)
                .stroke(Color.blue,
                        style: StrokeStyle(lineWidth: 1.5,
                                           dash: self.dash,
                                           dashPhase: self.phase))
                .frame(width: self.item?.geometry.size.width ?? 0,
                       height: self.item?.geometry.size.height ?? 0,
                       alignment: self.item?.geometry.alignment ?? .center)
                .gesture(self.gesture)
                
             // TODO:Support anchors ...
        }*/
    }
    
    
    // MARK: - Initialisation
    
    init(item: Binding<PJCLiveSurfaceItem?>)
    { self._item = item }
}

