//
//  PJCContextOptions.swift
//  LiveSurface
//
//  Created by Peter Spencer on 13/08/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import SwiftUI


typealias PJCContextOptionsHandler = () -> Void

/*protocol PJCContextOptions
{
    var options: [PJCContextOptionsHandler] { get }
}*/

struct PJCContextOptions {}

extension PJCContextOptions: View
{
    var body: some View
    {
        Rectangle().foregroundColor(.clear)
    }
}

struct PJCContextOptionsModifier: ViewModifier
{
    // MARK: -
    
    @State var isVisible: Bool = false
    
    let options: [PJCContextOptionsHandler]
    
    private var gesture: some Gesture
    {
        LongPressGesture().onEnded({ (_) in self.isVisible = true })
    }
    
    
    // MARK: -
    
    func body(content: Content) -> some View
    {
        ZStack
        {
            if self.isVisible
            {
                ZStack
                {
                    content.blur(radius: 5).clipped()
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 80, height: 200, alignment: .topLeading)
                        .foregroundColor(.green)
                        
                    VStack
                    {
                        Text("One").onTapGesture { print("1") }
                        Spacer().frame(height: 12)
                        Text("Two").onTapGesture { self.isVisible = false }
                    }
                }
            }
            else { content }
            
        }.gesture(self.gesture)
    }
}

extension View
{
    func onContextOptions(_ options: [PJCContextOptionsHandler]) -> some View
    {
        ModifiedContent(content: self,
                        modifier: PJCContextOptionsModifier(options: options))
    }
}

