//
//  Button+Extension.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public extension Button {
    func styled(
        _ theme: ButtonThemeType = .basic,
        variant: ButtonVariant = .fill,
        color: ButtonColor = .primary,
        size: ButtonSize = .large,
        shape: ButtonShape = .round
    ) -> some View {
        
        let buttonStyle = {
            switch theme {
            case .basic:
                let basicTheme = BasicButtonTheme(
                    variant: variant,
                    color: color
                )
                return ButtonStyleMaker(
                    theme: basicTheme,
                    size: size,
                    shape: shape
                )
            }
        }()
        
        return self.buttonStyle(buttonStyle)
    }
}
