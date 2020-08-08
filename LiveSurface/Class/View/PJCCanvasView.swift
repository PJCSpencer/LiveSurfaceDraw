//
//  PJCCanvasView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCCanvasView
{
    // MARK: - Property(s)
    
    @ObservedObject private(set) var project: PJCLiveSurfaceProject

    @ObservedObject private(set) var selectedItem: PJCLiveSurfaceItem
    
    @State var canvasColor: Color = .white
    
    
    // MARK: - Initialisation
    
    init(_ project: PJCLiveSurfaceProject,
         selectedItem: PJCLiveSurfaceItem?)
    {
        self.project = project
        self.selectedItem = selectedItem ?? PJCLiveSurfaceItem()
    }
}

extension PJCCanvasView: View
{
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            self.canvasColor.edgesIgnoringSafeArea(.all)
            
            ForEach(self.project.items.filter({ !$0.isHidden }))
            { (item) in PJCCanvasView.body(item) }
            
            if self.selectedItem.index >= 0 /* TODO:Resolve ... */
            {
                Toolset.tool(self.project.modtoolType,
                             for: self.selectedItem)
            }
        }
        .drawingGroup()
    }
}

