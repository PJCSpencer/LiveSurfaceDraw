//
//  PJCSimpleShapes.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


typealias PJCPathProviderHandler = (PJCLiveSurfaceItem) -> Path

protocol PJCPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path
}

class PJCSimpleShapes
{
    // MARK: - Constant(s)
    
    static let supported: [PJCPathProviderHandler] =
    [
        PJCCircle.path,
        PJCSquare.path,
        PJCTriangle.path
    ]
    
    // MARK: - Utility
    
    class func random() -> PJCPathProviderHandler
    {
        return Self.supported[Int.random(in: 0..<Self.supported.count)]
    }
}

// MARK: - Shape(s)
struct PJCCircle: Shape, PJCPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path // TODO:Support protocol ...
    { PJCCircle().path(in: item.geometry.rect) }
    
    func path(in rect: CGRect) -> Path
    { return Path(ellipseIn: rect) }
}

struct PJCSquare: Shape, PJCPathProvider
{
    static func path(_ item: PJCLiveSurfaceItem) -> Path 
    { PJCSquare().path(in: item.geometry.rect) }
    
    func path(in rect: CGRect) -> Path
    { return Path(rect) }
}

struct PJCTriangle: Shape, PJCPathProvider
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

