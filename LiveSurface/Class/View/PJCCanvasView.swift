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

    @State var canvasColor: Color = .white
    
    @Binding private(set) var selectedItem: PJCLiveSurfaceItem?
    
    
    // MARK: - Initialisation
    
    init(_ project: PJCLiveSurfaceProject,
         binding: Binding<PJCLiveSurfaceItem?>)
    {
        self.project = project
        self._selectedItem = binding // Nasty.
    }
}

extension PJCCanvasView: View
{
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            self.canvasColor.edgesIgnoringSafeArea(.all)
            
            ForEach(self.project.items)
            { (item) in PJCCanvasView.body(item) }
            
            Toolset.tool(self.project.modtoolType,
                         for: self.selectedItem)
        }
        .drawingGroup()
    }
}

// MARK: - PreviewProvider
struct PJCCanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCanvasView(PJCLiveSurfaceProject(),
                      binding: .constant(nil))
    }
}

