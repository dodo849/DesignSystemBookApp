//
//  IndividualBorderShape.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/16/24.
//

import SwiftUI

struct IndividualBorderView<Content: View>: View {
    let borderColor: BorderColor
    let lineWidth: CGFloat
    let rect: CGRect
    let content: () -> Content
    
    init(
        borderColor: BorderColor,
        lineWidth: CGFloat,
        rect: CGRect,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.borderColor = borderColor
        self.lineWidth = lineWidth
        self.rect = rect
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                }.stroke(borderColor.top.color, lineWidth: lineWidth)
                
                Path { path in
                    path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                }.stroke(borderColor.right.color, lineWidth: lineWidth)
                
                Path { path in
                    path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                }.stroke(borderColor.bottom.color, lineWidth: lineWidth)
                
                Path { path in
                    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
                }.stroke(borderColor.left.color, lineWidth: lineWidth)
            }
        }
    }
}
