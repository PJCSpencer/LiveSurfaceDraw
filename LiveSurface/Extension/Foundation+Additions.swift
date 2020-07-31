//
//  Foundation+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 30/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


extension Array
{
    static func *(source: Array,
                  multiplier: Int) -> Array
    {
        return (0...multiplier)
            .map({ (_) in source })
            .reduce([], +)
    }
}

