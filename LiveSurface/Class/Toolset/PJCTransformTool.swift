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
    
    init()
    {
        self.anchor = .zero
        self.start = .zero
        self.location = .zero
    }
    
    init(_ anchor: CGPoint,
         _ start: CGPoint,
         _ location: CGPoint)
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
                { self.drag = PJCTransformDrag(self.origin, value.startLocation, value.location) }
                
                guard self.controlPoint == nil else
                { return }
            
                self.origin = self.item.geometry.origin
                self.controlPoint = PJCSelectionView(rect: self.item.geometry.rect)
                    .controlPoints()
                    .filter({ $0.selectionFrame.contains(value.location) }).first
        }
        .onEnded
        { (value) in
            
            self.origin = .zero
            self.controlPoint = nil
            self.drag = nil
        }
    }
}

extension PJCTransformTool: View
{
    var body: some View
    { 
        if let drag = self.drag,
            let controlPoint = self.controlPoint,
            let handler = PJCTransform2D.table[controlPoint.position]
        {
            self.item.geometry = handler(self.item.geometry,
                                         drag)
        }
        
        return PJCSelectionView(rect: self.item.geometry.rect)
            .gesture(self.gesture)
    }
}

