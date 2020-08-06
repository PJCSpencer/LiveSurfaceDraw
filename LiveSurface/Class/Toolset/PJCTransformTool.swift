//
//  PJCTransformTool.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCTransformTool // TODO:Support PJCModifierProvider ...
{
    // MARK: - Property(s)
    
    private(set) var item: PJCLiveSurfaceItem
    
    @State private(set) var controlPoint: PJCControlPoint? = nil
    
    @State private(set) var offset: CGPoint = .zero
    
    private var gesture: some Gesture
    {
        DragGesture(minimumDistance: 1)
            .onChanged { value in
            
                if value.location.length > 0,
                    self.controlPoint != nil
                { self.offset = value.location }
            
                guard self.controlPoint == nil else
                { return }
            
                self.controlPoint = PJCSelectionView(rect: self.item.geometry.rect)
                    .controlPoints()
                    .filter({ $0.selectionFrame.contains(value.location) }).first
        }
        .onEnded
        { (value) in
            
            self.controlPoint = nil
            self.offset = .zero
        }
    }
}

extension PJCTransformTool: View
{
    var body: some View
    {
        if let controlPoint = self.controlPoint,
            let handler = PJCTransform2D.table[controlPoint.position]
        {
            self.item.geometry = handler(self.item.geometry,
                                         self.offset)
        }
        
        return PJCSelectionView(rect: self.item.geometry.rect)
            .gesture(self.gesture)
    }
}

