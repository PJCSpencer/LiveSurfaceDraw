//
//  PJCSelectionView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


enum PJCSelectionViewAnchorPosition
{
    case topLeft, topMiddle, topRight
    case middelLeft, middleRight
    case bottomLeft, bottomMiddle, bottomRight
}

struct PJCSelectionViewAnchor: View, Identifiable
{
    // MARK: - Constant(s)
    
    static let anchorRadius: CGFloat = 12
    
    
    // MARK: - Property(s)
    
    var id = UUID()
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        Circle()
            .fill(Color.blue)
            .frame(width: PJCSelectionViewAnchor.anchorRadius,
                   height: PJCSelectionViewAnchor.anchorRadius,
                   alignment: .center)
    }
}

