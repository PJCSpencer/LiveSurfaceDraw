//
//  PJCSelectionView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


protocol PJCControlPointShapeProvider
{
    var shape: PJCControlPointShape { get }
}

// MARK: - PJCSelectionControlPointShape
enum PJCControlPointShape
{
    case circle
    case square
}

extension PJCControlPointShape
{
    func path(_ rect: CGRect) -> Path
    { self == .circle ? Path(ellipseIn: rect) : Path(rect) }
}

// MARK: - PJCSelectionControlPointPosition
enum PJCControlPointPosition: CGPoint, CaseIterable
{
    case topLeft = "{0, 0}", topMiddle = "{0.5, 0}", topRight = "{1, 0}"
    case leftMiddle = "{0, 0.5}", rightMiddle = "{1, 0.5}"
    case bottomLeft = "{0, 1}", bottomMiddle = "{0.5, 1}", bottomRight = "{1, 1}"
}

extension PJCControlPointPosition: PJCControlPointShapeProvider
{
    var shape: PJCControlPointShape
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

struct PJCControlPoint: View, Identifiable
{
    // MARK: - Constant(s)
    
    static let radius: CGFloat = 4.0
    
    static let lineWidth: CGFloat = 1.5
    
    
    // MARK: - Property(s)
    
    var id = UUID()
    
    let shape: PJCControlPointShape
    
    let position: PJCControlPointPosition
    
    let controlFrame: CGRect
    
    var relativeFrame: CGRect
    {
        let pt = self.position.rawValue
        let x = self.controlFrame.origin.x + (self.controlFrame.width * pt.x) - PJCControlPoint.radius
        let y = self.controlFrame.origin.y + (self.controlFrame.height * pt.y) - PJCControlPoint.radius
        
        let size = CGSize(width: PJCControlPoint.radius * 2,
                          height: PJCControlPoint.radius * 2)
        
        return CGRect(origin: CGPoint(x: x, y: y),
                          size: size)
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        self.shape.path(self.relativeFrame).stroke(Color.blue,
                                                   lineWidth: PJCControlPoint.lineWidth)
    }
}

struct PJCSelectionControl: View
{
    // MARK: - Property(s)
    
    let frame: CGRect
    
    
    // MARK: - Return the Control Poinrs
    
    func controlPoints(_ frame: CGRect) -> [PJCControlPoint]
    {
        return PJCControlPointPosition.allCases
            .map({ PJCControlPoint(shape: $0.shape,
                                            position: $0,
                                            controlFrame: frame) })
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        ForEach(self.controlPoints(self.frame))
        { (controlPoint) in controlPoint }
    }
}

struct PJCSelectionModifier: ViewModifier
{
    // MARK: - Property(s)
    
    var frame: CGRect
    
    
    // MARK: - Implementing a Custom View
    
    func body(content: Content) -> some View
    {
        let cornerRadius: CGFloat = PJCControlPoint.radius * 2
        let wideCornerRadius: CGFloat = cornerRadius * 2
        let sides: [CGFloat] =
        [
            self.frame.width,
            self.frame.height,
            self.frame.width,
            self.frame.height
        ] * 2
        
        let dash = sides
            .map({ [$0 * 0.5 - wideCornerRadius] })
            .joined(separator: [wideCornerRadius])
        
        return ZStack
        {
            Path { path in path.addRect(frame) }.stroke(Color.blue,
                                                        style: StrokeStyle(lineWidth: 1,
                                                                           dash: Array(dash),
                                                                           dashPhase: -cornerRadius))
            
            PJCSelectionControl(frame: frame)
        }
    }
}

extension View
{
    func selected(_ frame: CGRect) -> some View
    {
        ModifiedContent(content: self,
                        modifier: PJCSelectionModifier(frame: frame))
    }
}

