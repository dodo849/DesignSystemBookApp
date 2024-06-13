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
        _ theme: ToggleButtonThemeType = .basic,
        color: ToggleButtonColor = .primary,
        shape: ToggleButtonShape = .round
    ) -> some View {
        let checkboxStyle = {
            switch theme {
            case .basic:
                let basicTheme = BasicCheckButtonTheme(color: color)
                return ToggleButtonStyleMaker(
                    theme: basicTheme,
                    shape: shape,
                    innerImage: shape.innerImage
                )
            }
        }()
        
        return self.toggleStyle(checkboxStyle)
    }
}

fileprivate extension ToggleButtonShape {
    var innerImage: Image {
        Image(systemName: "checkmark")
    }
}
