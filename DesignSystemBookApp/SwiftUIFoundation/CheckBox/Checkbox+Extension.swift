//
//  Checkbox+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct Checkbox<Label>: View where Label: View {
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

public extension Checkbox {
    func styled(
        _ theme: CheckboxThemeType = .basic,
        color: CheckboxColor = .primary,
        shape: CheckboxShape = .round
    ) -> some View {
        let checkboxStyle = {
            switch theme {
            case .basic:
                let basicTheme = BasicCheckboxTheme(color: color)
                return CheckboxStyleMaker(theme: basicTheme, shape: shape)
            }
        }()
        
        return self.toggleStyle(checkboxStyle)
    }
}
