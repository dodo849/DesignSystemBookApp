//
//  Radio.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct RadioButton<Label>: View where Label: View {
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

public extension RadioButton {
    func styled(
        _ theme: ToggleButtonThemeType = .basic,
        color: ToggleButtonColor = .primary,
        shape: ToggleButtonShape = .round
    ) -> some View {
        let checkboxStyle = {
            switch theme {
            case .basic:
                let basicTheme = BasicRadioButtonTheme(color: color)
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
        switch self {
        case .round: Image(systemName: "square.fill")
        case .square: Image(systemName: "squareshape.fill")
        case .circle: Image(systemName: "circle.fill")
        }
    }
}
