//
//  SingleRadioButton.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct SingleRadioButton<Label: View>: View, RadioButton {
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
        return Toggle(isOn: $isOn, label: label)
    }
}
