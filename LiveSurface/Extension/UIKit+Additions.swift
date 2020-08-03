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
    static func + (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    
    static func + (lhs: CGPoint,
                   rhs: CGSize) -> CGPoint
    { return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height) }
    
    static func - (lhs: CGPoint,
                   rhs: CGPoint) -> CGPoint
    { return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
}

extension CGSize
{
    func greaterThan(_ limit: CGFloat) -> CGSize // TODO:Support custom operator, which would communicate more ..?
    {
        return CGSize(width: self.width < limit ? limit : self.width,
                      height: self.height < limit ? limit : self.height)
    }
    
    static func + (lhs: CGSize,
                   rhs: CGPoint) -> CGSize
    { return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y) }
}

