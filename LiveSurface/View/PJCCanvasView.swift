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
    
    fileprivate var tap: some Gesture
    {
        DragGesture(minimumDistance: 0) // TODO:Researching using UIViewRepresentable as a background ...
            .onEnded { action in
                 
                let results = self.project.items.filter({ $0.path($0).contains(action.location) })
                self.selection = results.sorted(by: { $0.index > $1.index }).first
        }
    }
    
    @State private(set) var selection: PJCLiveSurfaceItem? = nil
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            Color(red: 1, green: 1, blue: 1).edgesIgnoringSafeArea(.all)
            
            ForEach(self.project.items)
            { (item) in item.path(item).fill(Color.black) }
        }
        .gesture(self.tap)
        .drawingGroup()
    }
    
    
    // MARK: - Initialisation
    
    init(_ project: PJCLiveSurfaceProject)
    { self.project = project }
}

struct PJCCanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCanvasView(PJCLiveSurfaceProject())
    }
}

