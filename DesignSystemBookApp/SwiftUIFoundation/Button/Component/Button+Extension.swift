//
//  Button+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public extension Button {
    // basic
    func styled(
        variant: BasicButtonVariant = .fill,
        color: BasicButtonColor = .primary,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) -> some View {
        let colorTheme = BasicButtonColorTheme(
            variant: variant,
            color: color
        )
        let figureTheme = BasicButtonFigureTheme(
            size: size,
            shape: shape
        )
        let buttonStyle = ButtonStyleMaker(
            colorTheme: colorTheme,
            figuretheme: figureTheme
        )
        
        return self.buttonStyle(buttonStyle)
    }
    
    // gray
    func styled(
        variant: BasicButtonVariant = .fill,
        color: GrayButtonColor = .mute,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) -> some View {
        let colorTheme = GrayButtonColorTheme(
            variant: variant,
            color: color
        )
        let figureTheme = BasicButtonFigureTheme(
            size: size,
            shape: shape
        )
        let buttonStyle = ButtonStyleMaker(
            colorTheme: colorTheme,
            figuretheme: figureTheme
        )
        
        return self.buttonStyle(buttonStyle)
    }
}
