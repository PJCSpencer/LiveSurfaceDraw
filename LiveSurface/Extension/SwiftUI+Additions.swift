//
//  SwiftUI+Additions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 29/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


extension View
{
    func asAnyView() -> AnyView
    { return AnyView(self) }
}

extension Path
{
    public func filled<S:ShapeStyle>(_ content: S,
                                     strokeStyle: StrokeStyle,
                                     strokeColor: Color = Color.black) -> some View
    {
        ZStack
        {
            self.fill(content)
            self.stroke(style: strokeStyle).fill(strokeColor)
        }
    }
}

