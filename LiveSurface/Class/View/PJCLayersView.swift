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
    
    @State var selectedItem: PJCLiveSurfaceItem? = nil
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        GeometryReader
        { geometry in
            
            List
            {
                ForEach(self.project.items)
                { (item) in
                        
                    PJCLayerPreview(item: item).onTapGesture
                    {
                        self.selectedItem = item
                    }
                    .padding()
                    .frame(width: geometry.size.width,
                           height: 70)
                }
            }
            .navigationBarTitle("Layers",
                                displayMode: .inline)
        }
    }
}

struct PJCLayersView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLayersView(project: PJCLiveSurfaceProject())
    }
}

