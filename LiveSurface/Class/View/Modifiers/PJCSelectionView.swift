//
//  PJCSelectionView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


protocol PJCSelectionControlPointShapeProvider
{
    var shape: PJCSelectionControlPointShape { get }
}

enum PJCSelectionControlPointShape
{
    case circle
    case square
}

extension PJCSelectionControlPointShape
{
    func path(_ rect: CGRect) -> Path
    {
        self == .circle ? Path(ellipseIn: rect) : Path(rect)
    }
}

enum PJCSelectionControlPointPosition: CGPoint, CaseIterable
{
    case topLeft = "{0, 0}", topMiddle = "{0.5, 0}", topRight = "{1, 0}"
    case leftMiddle = "{0, 0.5}", rightMiddle = "{1, 0.5}"
    case bottomLeft = "{0, 1}", bottomMiddle = "{0.5, 1}", bottomRight = "{1, 1}"
}

extension PJCSelectionControlPointPosition: PJCSelectionControlPointShapeProvider
{
    var shape: PJCSelectionControlPointShape
    {
        switch self
        {
        case .topLeft, .topRight, .bottomLeft, .bottomRight:
            return .circle
        default:
            return .square
        }
    }
}

struct PJCSelectionControlPoint: View, Identifiable
{
    // MARK: - Constant(s)
    
    static let radius: CGFloat = 4.0
    
    static let lineWidth: CGFloat = 1.5
    
    
    // MARK: - Property(s)
    
    var id = UUID()
    
    let frame: CGRect
    
    let shape: PJCSelectionControlPointShape
    
    let position: PJCSelectionControlPointPosition
    
    
    // MARK: -
    
    var body: some View
    {
        let pt = self.position.rawValue
        let x = frame.origin.x + (frame.width * pt.x) - PJCSelectionControlPoint.radius
        let y = frame.origin.y + (frame.height * pt.y) - PJCSelectionControlPoint.radius
        // print("\(self.position), \(self.shape), \(pt), \(x), \(y)")
        
        let size = CGSize(width: PJCSelectionControlPoint.radius * 2,
                          height: PJCSelectionControlPoint.radius * 2)
        let rect = CGRect(origin: CGPoint(x: x, y: y),
                          size: size)
        
        return self.shape.path(rect).stroke(Color.blue,
                                            lineWidth: PJCSelectionControlPoint.lineWidth)
    }
}

struct PJCSelectionControl: View
{
    let frame: CGRect
    
    func controlPoints(_ frame: CGRect) -> [PJCSelectionControlPoint]
    {
        return PJCSelectionControlPointPosition.allCases
            .map({ PJCSelectionControlPoint(frame: frame, shape: $0.shape, position: $0) })
    }
     
    var body: some View
    {
        ForEach(self.controlPoints(self.frame))
        { (controlPoint) in controlPoint }
    }
}

struct PJCSelectionModifier: ViewModifier
{
    var frame: CGRect
    
    func body(content: Content) -> some View
    {
        // let lineWidth: CGFloat = 1.5
        let radius: CGFloat = 4
        /*let size = CGSize(width: radius * 2,
                          height: radius * 2)*/
        
        let cornerRadius: CGFloat = radius * 2
        let wideCornerRadius: CGFloat = cornerRadius * 2
        let dash = [(frame.width * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.width * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.height * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.height * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.width * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.width * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.height * 0.5) - wideCornerRadius,
                    wideCornerRadius,
                    (frame.height * 0.5) - wideCornerRadius]
        
        return ZStack
        {
            Path { path in path.addRect(frame) }.stroke(Color.blue,
                                                        style: StrokeStyle(lineWidth: 1, dash: dash, dashPhase: -cornerRadius))
            
            PJCSelectionControl(frame: frame)
            
            // Corners.
            /*Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x - radius,
                                                                      y: frame.origin.y - radius),
                                                      size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x + frame.width - radius,
                                                                      y: frame.origin.y - radius),
                                                      size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x - radius,
                                                                      y: frame.origin.y + frame.height - radius),
                                                      size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addEllipse(in: CGRect(origin: CGPoint(x: frame.origin.x + frame.width - radius,
                                                                      y: frame.origin.y + frame.height - radius),
                                                      size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            // Sides.
            Path { path in path.addRect(CGRect(origin: CGPoint(x: frame.origin.x + (frame.width * 0.5) - radius,
                                                               y: frame.origin.y - radius),
                                                  size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addRect(CGRect(origin: CGPoint(x: frame.origin.x + frame.width - radius,
                                                               y: frame.origin.y + (frame.height * 0.5) - radius),
                                               size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addRect(CGRect(origin: CGPoint(x: frame.origin.x + (frame.width * 0.5) - radius,
                                                               y: frame.origin.y + frame.height - radius),
                                               size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)
            
            Path { path in path.addRect(CGRect(origin: CGPoint(x: frame.origin.x - radius,
                                                               y: frame.origin.y + (frame.height * 0.5) - radius),
                                               size: size)) }
                .stroke(Color.blue, lineWidth: lineWidth)*/
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

