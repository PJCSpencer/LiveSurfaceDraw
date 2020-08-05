//
//  PJCLayersView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayersView
{
    // MARK: - Property(s)
    
    @ObservedObject private(set) var project: PJCLiveSurfaceProject
    
    @Binding var selectedIndex: Int
}

extension PJCLayersView: View
{
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
                        self.selectedIndex = item.index
                    }
                    .frame(width: geometry.size.width,
                           height: 70)
                }
            }
            .navigationBarTitle("Layers",
                                displayMode: .inline)
        }
    }
}

// MARK: - PreviewProvider
struct PJCLayersView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCLayersView(project: PJCLiveSurfaceProject(),
                      selectedIndex: .constant(0))
    }
}

