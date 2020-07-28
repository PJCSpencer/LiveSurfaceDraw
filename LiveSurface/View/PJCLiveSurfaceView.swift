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
    
    var project: PJCLiveSurfaceProject = PJCLiveSurfaceProject()
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        PJCCanvasView(self.project)
    }
}

struct PJCLiveSurfaceView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLiveSurfaceView()
    }
}

