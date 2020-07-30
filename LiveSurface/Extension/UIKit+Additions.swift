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

