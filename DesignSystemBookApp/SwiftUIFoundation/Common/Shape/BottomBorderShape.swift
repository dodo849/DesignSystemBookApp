//
//  BottomBorderShape.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/16/24.
//

import SwiftUI

struct BottomBorderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draw the shape (rectangle in this case)
        path.addRect(rect)
        
        // Draw the bottom border
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - 1))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 1))
        
        return path
    }
}
