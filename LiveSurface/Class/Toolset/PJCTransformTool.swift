//
//  PJCTransformTool.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCTransformDrag
{
    // MARK: - Property(s)
    
    let anchor: CGPoint
    
    let start: CGPoint
    
    let location: CGPoint
    
    
    // MARK: - Initialisation
    
    init(_ anchor: CGPoint,
         start: CGPoint,
         location: CGPoint)
    {
        self.anchor = anchor
        self.start = start
        self.location = location
    }
}

struct PJCTransformTool // TODO:Support PJCModifierProvider ...
{
    // MARK: - Property(s)
    
    private(set) var item: PJCLiveSurfaceItem
    
    @State private(set) var controlPoint: PJCControlPoint? = nil
    
    @State private(set) var origin: CGPoint = .zero
    
    @State private(set) var drag: PJCTransformDrag? = nil
    
    private var gesture: some Gesture
    {
        DragGesture(minimumDistance: 1)
            .onChanged { value in
            
                if value.location.length > 0,
                    self.controlPoint != nil
                {
                    self.drag = PJCTransformDrag(self.origin,
                                                 start: value.startLocation,
                                                 location: value.location)
                }
                
                guard self.controlPoint == nil else
                { return }
                
                self.origin = self.item.geometry.origin
                self.controlPoint = PJCSelectionView(rect: self.item.geometry.rect)
                    .controlPoints()
                    .filter({ $0.selectionFrame.contains(value.location) }).first
        }
        .onEnded
        { (value) in
            
            self.controlPoint = nil
            self.origin = .zero
            self.drag = nil
        }
    }
}

extension PJCTransformTool: View
{
    var body: some View
    { 
        if let drag = self.drag,
            let position = self.controlPoint?.position,
            let handler = PJCTransform2D.table[position]
        {
            self.item.geometry = handler(self.item.geometry,
                                         drag)
        }
        
        return PJCSelectionView(rect: self.item.geometry.rect)
            .gesture(self.gesture)
    }
}

