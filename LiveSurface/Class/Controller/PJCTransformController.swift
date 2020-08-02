//
//  PJCTransformController.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


final class PJCTransformModifier: PJCModifierProvider
{
    fileprivate var item: PJCLiveSurfaceItem
    
    init?(_ item: PJCLiveSurfaceItem?)
    {
        guard let item = item else
        { return nil }
        
        self.item = item
    }
    
    func body() -> AnyView
    {
        Rectangle().selected(self.item.geometry.rect).asAnyView()
    }
}

protocol PJCDelegateClass: class { /* Whatever. */}

class PJCWeakDelegate
{
    private(set) weak var delegate: PJCDelegateClass?
    
    init(_ delegate: PJCDelegateClass)
    { self.delegate = delegate }
}

class PJCWeakLiveSurfaceProject
{
    private(set) weak var project: PJCLiveSurfaceProject?
    
    init(_ project: PJCLiveSurfaceProject)
    { self.project = project }
}

final class PJCTransformTool: PJCWeakDelegate, PJCModifierProvider2
{
    @Published var controlPoint: PJCControlPoint? = nil
    
    @Published var offset: CGPoint = .zero
    
    private var gesture: some Gesture
    {
        DragGesture(minimumDistance: 0)
        .onChanged { value in
            
            self.offset = value.location
            print("\(self.controlPoint?.position as Any), \(self.offset)")
             
            guard self.controlPoint == nil,
                let item = self.delegate as? PJCLiveSurfaceItem else
            { return }
            
            self.controlPoint = PJCSelectionView(rect: item.geometry.rect)
                .controlPoints()
                .filter({ $0.relativeFrame.contains(value.location) }).first
        }
        .onEnded
        { (value) in
                
            self.offset = .zero
            self.controlPoint = nil
        }
    }
    
    private var drag: some Gesture
    {
        DragGesture()
            .onChanged { value in print(value) }
            .onEnded { _ in /* self.selectedControlPoint = nil */ }
    }
    
    func body() -> AnyView
    {
        guard let item = self.delegate as? PJCLiveSurfaceItem else
        { return Rectangle().foregroundColor(.clear).asAnyView() }
        
        return Rectangle().selected(item.geometry.rect)
            .gesture(self.gesture).asAnyView()
    }
}





struct ModTool: View
{
    // var item: PJCLiveSurfaceItem
    
    @State private(set) var controlPoint: PJCControlPoint? = nil
    
    @State private(set) var offset: CGPoint = .zero
    
    @State private(set) var fixedGeometry: PJCGeometry
    
    private var gesture: some Gesture
    {
        DragGesture(minimumDistance: 1)
            .onChanged { value in
            
            if self.controlPoint != nil
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
            self.offset = .zero
        }
    }
    
    var body: some View
    {
        var frame = self.fixedGeometry.rect
        
        if self.offset.x > 0,
            let controlPoint = self.controlPoint,
            let handler = PJCTransform2D.table[controlPoint.position]
        {
            frame = handler(self.fixedGeometry, self.offset).rect
        }
        
        return PJCSelectionView(rect: frame)
            .gesture(self.gesture)
    }
}

