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
    
    @Binding var selectedIndex: Int
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
            
            Toolset.tool(self.project,
                         index: self.selectedIndex)
        }
        .drawingGroup()
    }
}

// MARK: - PreviewProvider
struct PJCCanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCanvasView(project: PJCLiveSurfaceProject(),
                      selectedIndex: .constant(0))
    }
}

