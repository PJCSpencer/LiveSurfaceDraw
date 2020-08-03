//
//  PJCCanvasView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCCanvasView: View
{
    // MARK: - Property(s)
    
    @ObservedObject private(set) var project: PJCLiveSurfaceProject

    @State var canvasColor: Color = .white
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        return ZStack(alignment: .topLeading)
        {
            self.canvasColor.edgesIgnoringSafeArea(.all)
            
            ForEach(self.project.items)
            { (item) in PJCCanvasView.body(item) }
            
            Toolset.tool(self.project)
        }
        .drawingGroup()
    }
}

struct PJCCanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCanvasView(project: PJCLiveSurfaceProject())
    }
}

