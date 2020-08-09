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
    
    @State private(set) var project: PJCLiveSurfaceProject = PJCLiveSurfaceProject()
    
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
                .navigationBarItems(leading: Button(action: self.project.share, label: { Image(systemName: "square.and.arrow.up") }),
                                    trailing: Button(action: self.project.add, label: { Text("New Shape") }))
            
            PJCCanvasView(self.project,
                          selectedItem: self.selectedItem).edgesIgnoringSafeArea(.all)
        }
        .padding(.leading, 0.95)
        .statusBar(hidden: true)
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

