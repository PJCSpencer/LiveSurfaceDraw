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
    
    @State var selectedIndex: Int = -1
}

extension PJCLiveSurfaceView: View
{
    var body: some View
    {
        NavigationView
        {
            PJCLayersView(project: self.project,
                          selectedIndex: self.$selectedIndex)
            
            PJCCanvasView(project: self.project,
                          selectedIndex: self.$selectedIndex)
        }
        .padding(.leading, 0.75)
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

