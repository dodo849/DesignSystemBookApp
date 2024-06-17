//
//  TextField.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

public extension TextField {
    // basic
    func styled(
        variant: BasicTextFieldVariant = .plain,
        color: BasicTextFieldColor = .primary,
        size: BasicTextFieldSize = .large,
        shape: BasicTextFieldShape = .round
    ) -> some View {
        let colorTheme = BasicTextFieldColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicTextFieldFigureTheme(
            size: size,
            shape: shape
        )
        
        let textFieldStyle = TextFieldStyleFactory(
            colorTheme: colorTheme,
            figureTheme: figureTheme,
            variant: variant
        )
        
        return self.textFieldStyle(textFieldStyle)
    }
}

public extension View {
    func state(_ state: TextFieldState) -> some View {
        return self.environment(\.textFieldState, state)
    }
    
    func suffix<Suffix: View>(@ViewBuilder _ suffix: @escaping () -> Suffix) -> some View {
        let suffixStyle = TextFieldSuffixStyleFactory(suffix: suffix)
        return self.textFieldStyle(suffixStyle)
    }
    
    func prefix<Prefix: View>(@ViewBuilder _ prefix: @escaping () -> Prefix) -> some View {
        let prefixStyle = TextFieldPrefixStyleFactory(prefix: prefix)
        return self.textFieldStyle(prefixStyle)
    }
}
