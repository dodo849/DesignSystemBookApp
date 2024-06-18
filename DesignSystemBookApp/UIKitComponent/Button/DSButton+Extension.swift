//
//  DSButton+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

extension DSButton {
    func styled(
        variant: BasicButtonVariant = .fill,
        color: BasicButtonColor = .primary,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) {
        let colorTheme = BasicButtonColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicButtonFigureTheme(
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}
