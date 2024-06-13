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
        _ theme: ToggleButtonThemeType = .basic,
        color: BasicToggleButtonColor = .primary,
        shape: BasicToggleButtonShape = .round
    ) -> some View {
        let checkboxStyle = {
                let colorTheme = BasicRadioButtonTheme(color: color)
                let fighureTheme = BasicToggleButtonFigureTheme(shape: shape)
                return ToggleButtonStyleMaker(
                    colorTheme: colorTheme,
                    figureTheme: fighureTheme,
                    innerImage: shape.innerImage
                )
        }()
        
        return self.toggleStyle(checkboxStyle)
    }
}

fileprivate extension BasicToggleButtonShape {
    var innerImage: Image {
        switch self {
        case .round: Image(systemName: "square.fill")
        case .square: Image(systemName: "squareshape.fill")
        case .circle: Image(systemName: "circle.fill")
        }
    }
}
