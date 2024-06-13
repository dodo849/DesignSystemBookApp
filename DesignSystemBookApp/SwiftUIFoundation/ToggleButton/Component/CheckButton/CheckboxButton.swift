//
//  CheckButton+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct CheckboxButton<Label>: View where Label: View {
    @Binding var isOn: Bool
    let label: () -> Label
    
    public init(
        isOn: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isOn = isOn
        self.label = label
    }
    
    public var body: some View {
        Toggle(isOn: $isOn, label: label)
    }
}

public extension CheckboxButton {
    func styled(
        color: BasicToggleButtonColor = .primary,
        shape: BasicToggleButtonShape = .round
    ) -> some View {
        let checkboxStyle = {
                let colorTheme = BasicCheckButtonColorTheme(color: color)
                let fighureTheme = BasicToggleButtonFigureTheme(shape: shape)
                return ToggleButtonStyleMaker(
                    colorTheme: colorTheme,
                    figureTheme: fighureTheme
                )
        }()
        
        return self.toggleStyle(checkboxStyle)
    }
}

fileprivate extension BasicToggleButtonShape {
    var innerImage: Image {
        Image(systemName: "checkmark")
    }
}
