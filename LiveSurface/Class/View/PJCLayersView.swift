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
    // MARK: - Constant(s)
    
    static let previewScale: CGFloat = 0.065
    
    
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
        { reader in
            
            List
            {
                ForEach(self.project.items)
                { (item) in
                    
                    PJCLayerPreview(item: item,
                                    projectSize: self.project.size * Self.previewScale).onTapGesture
                    {
                        self.selectedItem = item
                    }
                    .listRowBackground(self.selectedItem == item ? Color(UIColor.systemGroupedBackground) : Color.clear) // TODO:Resolve ...
                    .frame(width: reader.size.width,
                           height: 50)
                }
            }
            .navigationBarTitle("Layers")
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

