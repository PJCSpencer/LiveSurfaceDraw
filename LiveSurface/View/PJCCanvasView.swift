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
    
    let items: [PJCLiveSurfaceItem]
    
    fileprivate var tap: some Gesture
    {
        DragGesture(minimumDistance: 0) // TODO:Researching using UIViewRepresentable as a background ...
            .onEnded { action in
                 
                let results = self.items.filter({ $0.path($0).contains(action.location) })

                guard let _ = results.sorted(by: { $0.index > $1.index }).first else
                { return }
        }
    }
    
    
    // MARK: -
    
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            Color(red: 0, green: 1, blue: 1).edgesIgnoringSafeArea(.all)
            
            ForEach(self.items)
            { (item) in item.path(item).fill(Color.black) }
        }
        .gesture(self.tap)
        .drawingGroup()
    }
    
    
    // MARK: - Initialisation
    
    init(_ items: [PJCLiveSurfaceItem])
    { self.items = items }
}

struct PJCCanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCanvasView([])
    }
}

