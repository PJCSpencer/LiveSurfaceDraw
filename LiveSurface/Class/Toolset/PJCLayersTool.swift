//
//  PJCLayersTool.swift
//  LiveSurface
//
//  Created by Peter Spencer on 11/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCLayersTool
{
    @ObservedObject private(set) var item: PJCLiveSurfaceItem
    
    @State var frame: CGRect
}

extension PJCLayersTool: View
{
    var body: some View
    {
        TextField("\(self.item.name)", text: self.$item.name)
            .offset(self.frame.origin.size)
            .frame(width: self.frame.width, height: self.frame.height)
    }
}

