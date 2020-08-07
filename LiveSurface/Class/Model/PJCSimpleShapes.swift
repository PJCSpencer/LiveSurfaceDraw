//
//  PJCSimpleShapes.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


class PJCSimpleShapes
{
    // MARK: - Constant(s)
    
    static let supported: [PJCLiveSurfaceItemPathProviderHandler] =
    [
        PJCCircle().path,
        PJCSquare().path,
        PJCTriangle().path
    ]
    
    
    // MARK: - Utility
    
    class func random() -> PJCLiveSurfaceItemPathProviderHandler
    { return Self.supported[Int.random(in: 0..<Self.supported.count)] }
}

// MARK: - Shape(s)
struct PJCCircle: Shape, PJCLiveSurfaceItemPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path
    { PJCCircle().path(in: item.geometry.rect) }
    
    func path(in rect: CGRect) -> Path
    { return Path(ellipseIn: rect) }
}

struct PJCSquare: Shape, PJCLiveSurfaceItemPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path 
    { PJCSquare().path(in: item.geometry.rect) }
    
    func path(in rect: CGRect) -> Path
    { return Path(rect) }
}

struct PJCTriangle: Shape, PJCLiveSurfaceItemPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path
    { PJCTriangle().path(in: item.geometry.rect) }
    
    func path(in rect: CGRect) -> Path
    {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

