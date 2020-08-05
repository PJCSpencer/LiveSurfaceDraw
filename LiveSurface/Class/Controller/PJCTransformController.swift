//
//  PJCTransformController.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCModifierTool // PJCModifierProvider2
{
    /*fileprivate var item: PJCLiveSurfaceItem
    
    init?(_ item: PJCLiveSurfaceItem?)
    {
        guard let item = item else
        { return nil }
        
        self.item = item
    }*/
    
    // @Binding var selectedIndex: Int
    
    @State private(set) var controlPoint: PJCControlPoint? = nil
    
    @State private(set) var offset: CGPoint = .zero
    
    private(set) var fixedGeometry: PJCGeometry
    
    private var gesture: some Gesture
    {
        DragGesture(minimumDistance: 1)
            .onChanged { value in
            
                if value.location.x > 0,
                    self.controlPoint != nil
            { self.offset = value.location }
            
            guard self.controlPoint == nil else
            { return }
            
            self.controlPoint = PJCSelectionView(rect: self.fixedGeometry.rect)
                .controlPoints()
                .filter({ $0.selectionFrame.contains(value.location) }).first
        }
        .onEnded
        { (value) in
            
            self.controlPoint = nil
        }
    }
}

extension PJCModifierTool: View
{
    var body: some View
    {
        var frame = self.fixedGeometry.rect
        
        if let controlPoint = self.controlPoint,
            let handler = PJCTransform2D.table[controlPoint.position]
        {
            frame = handler(self.fixedGeometry,
                            self.offset).rect
        }
        
        return PJCSelectionView(rect: frame)
            .gesture(self.gesture)
    }
}

