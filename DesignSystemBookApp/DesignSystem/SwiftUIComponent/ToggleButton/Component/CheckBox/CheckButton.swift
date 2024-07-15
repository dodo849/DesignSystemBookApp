//
//  CheckBox+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct CheckBox<Label>: View where Label: View {
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

public extension CheckBox {
    func styled(
        color: BasicToggleButtonColor = .primary,
        shape: BasicToggleButtonShape = .round
    ) -> some View {
        let checkboxStyle = {
                let colorTheme = BasicCheckButtonColorTheme(color: color)
                let fighureTheme = BasicToggleButtonFigureTheme(shape: shape)
                return ToggleButtonStyleFactory(
                    colorTheme: colorTheme,
                    figureTheme: fighureTheme,
                    innerImage: shape.innerImage
                )
        }()
        
        return self.toggleStyle(checkboxStyle)
    }
}

private extension BasicToggleButtonShape {
    var innerImage: Image {
        Image(systemName: "checkmark")
    }
}
