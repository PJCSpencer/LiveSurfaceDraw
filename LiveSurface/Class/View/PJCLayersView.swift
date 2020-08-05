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
    
    @Binding private(set) var selectedItem: PJCLiveSurfaceItem?
    
    
    // MARK: - Initialisation
    
    init(_ project: PJCLiveSurfaceProject,
         binding: Binding<PJCLiveSurfaceItem?>)
    {
        self.project = project
        self._selectedItem = binding // Yes, nasty.
    }
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
                        self.selectedItem = item
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
        PJCLayersView(PJCLiveSurfaceProject(),
                      binding: .constant(nil))
    }
}

