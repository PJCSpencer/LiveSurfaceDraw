//
//  CGGeometry+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 04/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


extension CGPoint: ExpressibleByStringLiteral
{
    public init(stringLiteral value: StringLiteralType)
    { self = NSCoder.cgPoint(for: value) }

    public init(extendedGraphemeClusterLiteral value: StringLiteralType)
    { self = NSCoder.cgPoint(for: value) }

    public init(unicodeScalarLiteral value: StringLiteralType)
    { self = NSCoder.cgPoint(for: value) }
}

extension CGRect
{
    // MARK: - Property(s)
    
    var center: CGPoint
    { return CGPoint(x: midX, y: midY) }
    
    var concatenated: CGPoint
    { return (self.origin + self.size) }
    
    
    // MARK: - Utility
    
    func inset(by value: CGFloat) -> CGRect
    {
        return self.inset(by: UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: value,
                                           right: value))
    }
    
    func checkerboard(_ size: CGSize) -> [[Self]]
    {
        let width = CGFloat(self.width / size.width)
        let height = CGFloat(self.height / size.height)
        
        return size.checkerboard().enumerated().map
        { (rowIndex, rowValue) in
            
            rowValue.enumerated().compactMap
            { (columnIndex, columnValue) in
                
                guard columnValue else { return nil }
                
                return CGRect(origin: CGPoint(x: width * CGFloat(columnIndex),
                                              y: height * CGFloat(rowIndex)),
                              size: CGSize(width: width,
                                           height: height))
            }
        }
    }
}

extension CGPoint
{
    // MARK: - Constant(s)
    
    static let unit: CGPoint = CGPoint(x: 1, y: 1)
    
    static let unitX: CGPoint = CGPoint(x: 1, y: 0)
    
    static let unitXNegative: CGPoint = CGPoint(x: -1, y: 1)
    
    static let unitY: CGPoint = CGPoint(x: 0, y: 1)
    
    static let unitYNegative: CGPoint = CGPoint(x: 1, y: -1)
    
    
    // MARK: - Conversion
    
    var size: CGSize
    { return CGSize(width: self.x, height: self.y) }
    
    
    // MARK: - Utility
    
    var length: CGFloat
    { return sqrt(self.x * self.x + self.y * self.y) }
    
    
    // MARK: - Containment
    
    func greaterThan(_ value: CGFloat) -> CGPoint
    {
        return CGPoint(x: self.x < value ? value : self.x,
                       y: self.y < value ? value : self.y)
    }
    
    
    // MARK: - Operator(s)
    
    static func + (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    
    static func + (lhs: CGPoint,
                   rhs: CGSize) -> CGPoint
    { return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height) }
    
    static func - (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
    
    static func - (lhs: CGPoint,
                   rhs: CGFloat) -> CGPoint
    { return CGPoint(x: lhs.x - rhs, y: lhs.y - rhs) }
    
    static func - (lhs: CGPoint,
                   rhs: CGSize) -> CGPoint
    { return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height) }
    
    static func * (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y) }
    
    static func * (lhs: CGPoint,
                   rhs: CGSize) -> CGPoint
    { return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height) }
    
    static func * (lhs: CGPoint,
                   rhs: CGFloat) -> CGPoint
    { return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs) }
}

extension CGSize
{
    // MARK: - Constant(s)
    
    static let unit: CGSize = CGSize(width: 1, height: 1)
    
    static let unitWidth: CGSize = CGSize(width: 1, height: 0)
    
    static let unitWidthNegative: CGSize = CGSize(width: -1, height: 1)
    
    static let unitHeight: CGSize = CGSize(width: 0, height: 1)
    
    static let unitHeightNegative: CGSize = CGSize(width: 1, height: -1)
    
    static let unitMiddle: CGSize = CGSize(width: 0.5, height: 0.5)
    
    
    // MARK: - Conversion
    
    var point: CGPoint
    { return CGPoint(x: self.width, y: self.height) }
    
    func centered(in source: CGSize) -> CGRect
    {
        return CGRect(origin: CGPoint(x: (source.width * 0.5) - (self.width * 0.5),
                                      y: (source.height * 0.5) - (self.height * 0.5)),
                      size: self)
    }
    
    func scaled(relativeTo source: CGSize) -> CGSize
    {
        let slope = 1.0 / self * source   
        return self * (slope.width > slope.height ? slope.height : slope.width)
    }
    
    
    // MARK: - Utility
    
    func inset(by value: CGFloat) -> CGSize
    {
        return CGSize(width: self.width - value,
                      height: self.height - value)
    }
    
    func checkerboard() -> [[Bool]]
    {
        let numberOfRows = Int(self.height)
        let numberOfColumns = Int(self.width)
        
        return (0..<numberOfRows).map
        {
            $0 % 2 == 0
                ? (0..<numberOfColumns).map { $0 % 2 == 0 }
                : (0..<numberOfColumns).map { $0 % 2 == 1 }
        }
    }

    
    // MARK: - Comparison
    
    static func <= (_ lhs: CGSize,
                    rhs: CGFloat) -> Bool
    { return lhs.width <= rhs || lhs.height <= rhs }
    
    
    // MARK: - Containment
    
    func lessThan(_ value: CGFloat) -> CGSize
    {
        return CGSize(width: self.width > value ? value : self.width,
                      height: self.height > value ? value : self.height)
    }
    
    func greaterThan(_ value: CGFloat) -> CGSize // TODO:Support custom operator, which would communicate more ..?
    {
        return CGSize(width: self.width < value ? value : self.width,
                      height: self.height < value ? value : self.height)
    }
    
    
    // MARK: - Operator(s)
    
    static func + (lhs: CGSize,
                   rhs: CGSize) -> CGSize
    { return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    
    static func + (lhs: CGSize,
                   rhs: CGPoint) -> CGSize
    { return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y) }
    
    static func - (lhs: CGSize,
                   rhs: CGSize) -> CGSize
    { return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }
    
    static func - (lhs: CGSize,
                   rhs: CGPoint) -> CGSize
    { return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y) }
    
    static func - (lhs: CGSize,
                   rhs: CGFloat) -> CGSize
    { return CGSize(width: lhs.width - rhs, height: lhs.height - rhs) }
    
    static func * (lhs: CGSize,
                   rhs: CGSize) -> CGSize
    { return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height) }
    
    static func * (lhs: CGSize,
                   rhs: CGFloat) -> CGSize
    { return CGSize(width: lhs.width * rhs, height: lhs.height * rhs) }
    
    static func / (lhs: CGFloat,
                   rhs: CGSize) -> CGSize
    { return CGSize(width: lhs / rhs.width, height: lhs / rhs.height) }
    
    static func / (lhs: CGSize,
                   rhs: Int) -> CGSize
    { return CGSize(width: Int(lhs.width) / rhs, height: Int(lhs.height) / rhs) }
}

