//
//  PJCLayersView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayersView: View
{
    // MARK: - Property(s)
    
    @ObservedObject private(set) var project: PJCLiveSurfaceProject
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        List 
        {
            ForEach(self.project.items)
            { (item) in Text(item.name).frame(height: 70) }
        }
        .navigationBarTitle("Layers", displayMode: .inline)
    }
}

struct PJCLayersView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLayersView(project: PJCLiveSurfaceProject())
    }
}

