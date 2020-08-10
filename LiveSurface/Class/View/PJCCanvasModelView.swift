//
//  PJCCanvasModelView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCCanvasModelView
{
    // MARK: - Property(s)
    
    @ObservedObject private(set) var item: PJCLiveSurfaceItem
}

extension PJCCanvasModelView: View // TODO:Extend to support styling ...
{
    var body: some View
    {
        if self.item.isHidden
        { return EmptyView().asAnyView() }
        
        return self.item.path(self.item.geometry.rect)
            .fill(Color(white: 0.9))
            .asAnyView()
    }
}

