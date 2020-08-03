//
//  UIKit+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 30/07/2020.
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
    var center: CGPoint
    { return CGPoint(x: midX, y: midY) }
}

extension CGPoint
{
    // MARK: - Constant(s)
    
    static let unitY: CGPoint = CGPoint(x: 0, y: 1)
    
    static let unitYNegative: CGPoint = CGPoint(x: 1, y: -1)
    
    
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
    
    static func * (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y) }
    
    static func * (lhs: CGPoint,
                   rhs: CGSize) -> CGPoint
    { return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height) }
}

extension CGSize
{
    // MARK: - Constant(s)
    
    static let unit: CGSize = CGSize(width: 1, height: 1)
    
    static let unitWidth: CGSize = CGSize(width: 1, height: 0)
    
    static let unitHeight: CGSize = CGSize(width: 0, height: 1)
    
    
    // MARK: - Containment
    
    func lessThan(_ limit: CGFloat) -> CGSize
    {
        return CGSize(width: self.width > limit ? limit : self.width,
                      height: self.height > limit ? limit : self.height)
    }
    
    func greaterThan(_ limit: CGFloat) -> CGSize // TODO:Support custom operator, which would communicate more ..?
    {
        return CGSize(width: self.width < limit ? limit : self.width,
                      height: self.height < limit ? limit : self.height)
    }
    
    
    // MARK: - Operator(s)
    
    static func + (lhs: CGSize,
                   rhs: CGPoint) -> CGSize
    { return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y) }
    
    static func - (lhs: CGSize,
                   rhs: CGPoint) -> CGSize
    { return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y) }
    
    static func * (lhs: CGSize,
                   rhs: CGSize) -> CGSize
    { return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height) }
}

