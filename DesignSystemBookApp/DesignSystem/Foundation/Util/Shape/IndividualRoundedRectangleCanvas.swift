//
//  IndividualRoundedRectangleCanvas.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/16/24.
//

import SwiftUI

struct IndividualRoundedRectangleCanvas: View {
    var topLeftRadius: CGFloat
    var topRightRadius: CGFloat
    var bottomLeftRadius: CGFloat
    var bottomRightRadius: CGFloat

    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size)
            let shape = IndividualRoundedRectangle(
                topLeftRadius: topLeftRadius,
                topRightRadius: topRightRadius,
                bottomLeftRadius: bottomLeftRadius,
                bottomRightRadius: bottomRightRadius
            )
            
            let path = shape.path(in: rect)
            context.fill(path, with: .color(Color(red: 250/255, green: 100/255, blue: 90/255)))
        }
    }
}
