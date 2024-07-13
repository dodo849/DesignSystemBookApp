//
//  Radio.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public protocol RadioButton: View { }

public extension RadioButton {
    func styled(
        color: BasicToggleButtonColor = .primary,
        shape: BasicToggleButtonShape = .round
    ) -> some View {
        let colorTheme = BasicRadioButtonTheme(color: color)
        
        let figureTheme = BasicToggleButtonFigureTheme(shape: shape)
        
        let radioButtonStyle = ToggleButtonStyleFactory(
            colorTheme: colorTheme,
            figureTheme: figureTheme,
            innerImage: shape.innerImage
        )
        
        return self.toggleStyle(radioButtonStyle)
    }
}

private extension BasicToggleButtonShape {
    var innerImage: Image {
        switch self {
        case .round: Image(systemName: "square.fill")
        case .square: Image(systemName: "squareshape.fill")
        case .circle: Image(systemName: "circle.fill")
        }
    }
}
