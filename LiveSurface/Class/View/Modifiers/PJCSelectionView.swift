//
//  PJCSelectionView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 28/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


let PJCHiddenButResponsiveOpacity: Double = 0.075

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
    
    static var hitTestingScale: CGFloat = 3.0
    
    
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
    
    var selectionFrame: CGRect
    {
        let radius: CGFloat = PJCControlPoint.radius * PJCControlPoint.hitTestingScale
        let pt = self.position.rawValue
        let x = self.controlFrame.origin.x + (self.controlFrame.width * pt.x) - radius
        let y = self.controlFrame.origin.y + (self.controlFrame.height * pt.y) - radius
        
        let size = CGSize(width: radius * 2,
                          height: radius * 2)
        
        return CGRect(origin: CGPoint(x: x, y: y),
                      size: size)
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        ZStack
        {
            self.shape.path(self.selectionFrame)
                .fill(Color(red: 0,
                            green: 0,
                            blue: 1,
                            opacity: PJCHiddenButResponsiveOpacity))
            
            self.shape.path(self.relativeFrame)
                .stroke(Color.blue,
                        lineWidth: PJCControlPoint.lineWidth)
        }
    }
}

struct PJCSelectionView: View
{
    // MARK: - Constant(s)
    
    static var minimumCombinedRadius: CGFloat = (PJCControlPoint.radius * PJCControlPoint.hitTestingScale) * 3
    
    static func constrained(_ dim: CGFloat) -> CGFloat /* TODO:Support operator ... */
    {
        return dim < PJCSelectionView.minimumCombinedRadius
            ? PJCSelectionView.minimumCombinedRadius
            : dim
    }
    
    
    // MARK: - Property(s)
    
    let rect: CGRect
    
    
    // MARK: - Returning the Control Points
    
    func controlPoints() -> [PJCControlPoint]
    {
        return PJCControlPointPosition.allCases
            .map({ PJCControlPoint(shape: $0.shape,
                                            position: $0,
                                            controlFrame: self.rect) })
    }
    
    
    // MARK: - Implementing a Custom View
    
    var body: some View
    {
        let cornerRadius: CGFloat = PJCControlPoint.radius * 2
        let wideCornerRadius: CGFloat = cornerRadius * 2
        let sides: [CGFloat] = [rect.size.width, rect.size.height].map({ [$0 * 0.5] * 2 }).reduce([], +) * 2
        
        let dash = sides
            .map({ [$0 - wideCornerRadius] })
            .joined(separator: [wideCornerRadius])
        
        let scaledRect = self.rect.insetBy(dx: -wideCornerRadius,
                                           dy: -wideCornerRadius)
        
        return ZStack
        {
            Path() { path in path.addRect(scaledRect) }
                .foregroundColor(Color(red: 0, green: 0, blue: 1, opacity: PJCHiddenButResponsiveOpacity))
            
            Path() { path in path.addRect(self.rect) }
                .stroke(Color.blue,
                        style: StrokeStyle(lineWidth: 1,
                                           dash: Array(dash),
                                           dashPhase: -cornerRadius))
                .allowsHitTesting(false)
            
            ForEach(self.controlPoints())
            { (controlPoint) in controlPoint }.allowsHitTesting(false)
        }
    }
}

struct PJCSelectionModifier: ViewModifier
{
    // MARK: - Property(s)
    
    var frame: CGRect
    
    
    // MARK: - Implementing a Custom View
    
    func body(content: Content) -> some View
    {
        PJCSelectionView(rect: frame)
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

