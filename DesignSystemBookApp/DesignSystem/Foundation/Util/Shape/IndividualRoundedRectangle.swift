//
//  IndividualRoundedRectangle.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

struct IndividualRoundedRectangle: Shape {
    var topLeftRadius: CGFloat
    var topRightRadius: CGFloat
    var bottomLeftRadius: CGFloat
    var bottomRightRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        
        // Top edge and top-right corner
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        path.addArc(
            center: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
            radius: topRightRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // Right edge and bottom-right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        path.addArc(
            center: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
            radius: bottomRightRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // Bottom edge and bottom-left corner
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        path.addArc(
            center: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
            radius: bottomLeftRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // Left edge and top-left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(
            center: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
            radius: topLeftRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        
        return path
    }
}
