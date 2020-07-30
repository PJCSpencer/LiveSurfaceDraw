//
//  PJCSelectionView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


enum PJCSelectionControlPointShape
{
    case circle
    case square
}

enum PJCSelectionControlPointPosition
{
    case topLeft, topMiddle, topRight
    case middelLeft, middleRight
    case bottomLeft, bottomMiddle, bottomRight
}

struct PJCSelectionControlPoint: View, Identifiable
{
    var id = UUID()
    
    let shape: PJCSelectionControlPointShape
    
    let position: PJCSelectionControlPointPosition
    
    var body: some View
    {
        Text("")
    }
}

struct PJCSelectionControl: View
{
    let controlPoints: [PJCSelectionControlPoint] = []
    
    var body: some View
    {
        Text("")
    }
}

struct PJCSelectionModifier: ViewModifier
{
    var frame: CGRect
    
    func body(content: Content) -> some View
    {
        let lineWidth: CGFloat = 1.5
        let radius: CGFloat = 4
        let size = CGSize(width: radius * 2,
                          height: radius * 2)
        
        let cornerRadius: CGFloat = radius * 2
        let wideCornerRadius: CGFloat = cornerRadius * 2
        let _ = [0,
                    cornerRadius,
                    frame.width - wideCornerRadius,
                    wideCornerRadius,
                    frame.height - wideCornerRadius,
                    wideCornerRadius,
                    frame.width - wideCornerRadius,
                    cornerRadius]
        
        return ZStack
        {
            Path { path in path.addRect(frame) }.stroke(Color.blue,
                                                        style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x - radius,
                                                                      y: frame.origin.y - radius),
                                                      size: size)) }
                .filled(Color.white,
                        strokeStyle: StrokeStyle(lineWidth: lineWidth),
                        strokeColor: Color.blue)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x + frame.width - radius,
                                                                      y: frame.origin.y - radius),
                                                      size: size)) }
                .filled(Color.white,
                        strokeStyle: StrokeStyle(lineWidth: lineWidth),
                        strokeColor: Color.blue)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x - radius,
                                                                      y: frame.origin.y + frame.height - radius),
                                                      size: size)) }
                .filled(Color.white,
                        strokeStyle: StrokeStyle(lineWidth: lineWidth),
                        strokeColor: Color.blue)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x + frame.width - radius,
                                                                      y: frame.origin.y + frame.height - radius),
                                                      size: size)) }
                .filled(Color.white,
                        strokeStyle: StrokeStyle(lineWidth: lineWidth),
                        strokeColor: Color.blue)
        }
    }
}

extension View
{
    func selected(_ frame: CGRect) -> some View
    {
        ModifiedContent(content: self, modifier: PJCSelectionModifier(frame: frame))
    }
}

