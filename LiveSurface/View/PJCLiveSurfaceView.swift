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
    
    @State var items: [PJCLiveSurfaceItem] = PJCLiveSurfaceItem.mocked
    
    
    // MARK: -
    
    var body: some View
    {
        PJCCanvasView(self.items)
    }
}

struct PJCLiveSurfaceView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLiveSurfaceView()
    }
}

