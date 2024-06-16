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
    
    func prefix(_ prefix: String) -> some View {
        return self.environment(\.textFieldPrefix, prefix)
    }
    
    func suffix(_ prefix: String) -> some View {
        return self.environment(\.textFieldSuffix, prefix)
    }
}


struct TextFieldPrefixKey: EnvironmentKey {
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    var textFieldPrefix: String {
        get { self[TextFieldPrefixKey.self] }
        set { self[TextFieldPrefixKey.self] = newValue }
    }
}

struct TextFieldSuffixKey: EnvironmentKey {
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    var textFieldSuffix: String {
        get { self[TextFieldSuffixKey.self] }
        set { self[TextFieldSuffixKey.self] = newValue }
    }
}
