//
//  PJCCheckerboardView.swift
//  LiveSurface
//
//  Created by Peter Spencer on 09/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


struct PJCCheckerboardShape: Identifiable
{
    var id = UUID()
    
    let rect: CGRect
}

struct PJCCheckerboardView
{
    @State var scale: Int = 10
    
    @State var fgColor: Color = Color(white: 0.98)
    
    @State var bgColor: Color = Color.white
}

extension PJCCheckerboardView: View
{
    var body: some View
    {
        GeometryReader
        { reader in
            
            ZStack(alignment: .topLeading)
            {
                self.bgColor
                
                ForEach(CGRect(origin: .zero, size: reader.size)
                    .checkerboard(reader.size / self.scale)
                    .reduce([], +)
                    .map({ PJCCheckerboardShape(rect: $0) }))
                {
                    Rectangle()
                        .foregroundColor(self.fgColor)
                        .offset(x: $0.rect.origin.x, y: $0.rect.origin.y)
                        .frame(width: $0.rect.width, height: $0.rect.height)
                }
            }
            .drawingGroup()
        }
    }
}

// MARK: - PreviewProvider
struct PJCCheckerboardView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PJCCheckerboardView()
    }
}

