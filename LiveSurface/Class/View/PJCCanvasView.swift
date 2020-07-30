//
//  PJCCanvasView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


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
    
    fileprivate var gesture: some Gesture
    {
        DragGesture(minimumDistance: 0) // TODO:Researching using UIViewRepresentable as a background ...
            .onEnded { action in
                 
                let results = self.project.items.filter({ $0.path($0).contains(action.location) })
                let selection = results.sorted(by: { $0.index > $1.index }).first
                
                self.modifier = TransformModifier(selection)
        }
    }
    
    @State private(set) var modifier: PJCModifierProvider?
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            Color(red: 1, green: 1, blue: 1).edgesIgnoringSafeArea(.all)
            
            ForEach(self.project.items)
            { (item) in PJCCanvasView.body(item) }
            
            self.modifier?.body()
        }
        .gesture(self.gesture)
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

