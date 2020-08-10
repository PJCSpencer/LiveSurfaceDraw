//
//  PJCCanvasView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCCanvasView // TODO:Support Metal ...
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
        self.selectedItem = selectedItem ?? PJCLiveSurfaceItem.identity
    }
}

extension PJCCanvasView: View
{
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            PJCCheckerboardView()
             
            ForEach(self.project.items)
            { (item) in PJCCanvasModelView(item: item) }
            
            Toolset.tool(self.project.modtoolType,
                         for: self.selectedItem)
        }
        .drawingGroup()
    }
}

