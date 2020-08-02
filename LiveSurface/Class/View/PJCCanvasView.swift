//
//  PJCCanvasView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


protocol PJCModifierProvider2
{
    // var project: PJCLiveSurfaceProject? { get }
    
    // init(_ project: PJCLiveSurfaceProject)
    
    // var cache: [?]
    
    func body() -> AnyView
}

protocol PJCModifierProvider
{
    // init(_ binding: Binding<PJCLiveSurfaceItem?>)
    
    // @Binding var binding: PJCLiveSurfaceItem?
    
    init?(_ item: PJCLiveSurfaceItem?)
    
    func body(/*to selection: PJCLiveSurfaceItem?*/) -> AnyView
}

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

