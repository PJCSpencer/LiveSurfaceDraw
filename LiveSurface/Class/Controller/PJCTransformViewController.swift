//
//  PJCTransformViewController.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


final class TransformModifier: PJCModifierProvider
{
    fileprivate var item: PJCLiveSurfaceItem
    
    fileprivate var gesture: some Gesture // TODO:Needs to be refactored to support gesture sequencing ...
    {
        DragGesture()
            .onChanged { value in }
            .onEnded { _ in }
    }
    
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

