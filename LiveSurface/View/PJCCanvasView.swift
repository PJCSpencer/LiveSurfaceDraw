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
    
    
    // MARK: -
    
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            Color(red: 0, green: 1, blue: 1).edgesIgnoringSafeArea(.all)
            
            ForEach(self.items)
            { (item) in PJCCanvasView.body(item) }
            
        }.drawingGroup()
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

