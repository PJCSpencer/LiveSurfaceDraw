//
//  PJCLiveSurfaceView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLiveSurfaceView: View
{
    // MARK: - Property(s)
    
    private(set) var project: PJCLiveSurfaceProject = PJCLiveSurfaceProject()
    
    @State private(set) var modifier: PJCModifierProvider?
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        PJCCanvasView(project: self.project)
        
        /*NavigationView
        {
            PJCLayersView(project: self.project)
            PJCCanvasView(project: self.project) // PJCCanvasView(project: self.project, modifier: self.modifier)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))*/
    }
}

struct PJCLiveSurfaceView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLiveSurfaceView()
    }
}

