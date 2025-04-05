//
//  MessageBubble.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


import SwiftUI

struct MessageBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let tailWidth: CGFloat = 15
        let tailHeight: CGFloat = 10

        // Main bubble rectangle, leaving room for tail on the left and bottom.
        let bubbleRect = CGRect(x: tailWidth, y: 0, width: rect.width - tailWidth, height: rect.height - tailHeight)
        path.addRoundedRect(in: bubbleRect, cornerSize: CGSize(width: 12, height: 12))
        
        // Tail: A curved tail on the bottom left.
        let startPoint = CGPoint(x: tailWidth, y: bubbleRect.maxY)
        let endPoint = CGPoint(x: tailWidth, y: bubbleRect.maxY + tailHeight)
        let cp1 = CGPoint(x: 0, y: bubbleRect.maxY + tailHeight * 0.3)
        let cp2 = CGPoint(x: 0, y: bubbleRect.maxY + tailHeight * 0.7)
        path.move(to: startPoint)
        path.addCurve(to: endPoint, control1: cp1, control2: cp2)
        
        return path
    }
}
