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

// MARK: - PJCSelectionControlPointShape
enum PJCSelectionControlPointShape
{
    case circle
    case square
}

extension PJCSelectionControlPointShape
{
    func path(_ rect: CGRect) -> Path
    { self == .circle ? Path(ellipseIn: rect) : Path(rect) }
}

// MARK: - PJCSelectionControlPointPosition
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
    
    let shape: PJCSelectionControlPointShape
    
    let position: PJCSelectionControlPointPosition
    
    let controlFrame: CGRect
    
    var relativeFrame: CGRect
    {
        let pt = self.position.rawValue
        let x = self.controlFrame.origin.x + (self.controlFrame.width * pt.x) - PJCSelectionControlPoint.radius
        let y = self.controlFrame.origin.y + (self.controlFrame.height * pt.y) - PJCSelectionControlPoint.radius
        
        let size = CGSize(width: PJCSelectionControlPoint.radius * 2,
                          height: PJCSelectionControlPoint.radius * 2)
        
        return CGRect(origin: CGPoint(x: x, y: y),
                          size: size)
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        self.shape.path(self.relativeFrame).stroke(Color.blue,
                                                   lineWidth: PJCSelectionControlPoint.lineWidth)
    }
}

struct PJCSelectionControl: View
{
    // MARK: - Property(s)
    
    let frame: CGRect
    
    
    // MARK: - Return the Control Poinrs
    
    func controlPoints(_ frame: CGRect) -> [PJCSelectionControlPoint]
    {
        return PJCSelectionControlPointPosition.allCases
            .map({ PJCSelectionControlPoint(shape: $0.shape,
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
        let cornerRadius: CGFloat = PJCSelectionControlPoint.radius * 2
        let wideCornerRadius: CGFloat = cornerRadius * 2
        let sides: [CGFloat] =
        [
            self.frame.width,
            self.frame.height,
            self.frame.width,
            self.frame.height
        ]
        
        // TODO:Support multiply custom operator on array ...
        let dash = (sides + sides)
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

