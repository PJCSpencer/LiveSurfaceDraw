//
//  PJCLiveSurfaceView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLiveSurfaceView
{
    // MARK: - Property(s)
    
    private(set) var project: PJCLiveSurfaceProject = PJCLiveSurfaceProject()
    
    @State private(set) var selectedItem: PJCLiveSurfaceItem? = nil
}

extension PJCLiveSurfaceView: View
{
    var body: some View
    {
        NavigationView
        {
            PJCLayersView(self.project,
                          binding: self.$selectedItem)
            
            PJCCanvasView(self.project,
                          binding: self.$selectedItem)
        }
        .padding(.leading, 0.95)
    }
}

// MARK: - PreviewProvider
struct PJCLiveSurfaceView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLiveSurfaceView()
    }
}

