//
//  RadioOption.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public struct RadioOption<Label: View, Option: Equatable & Identifiable>: View {
    @EnvironmentObject var store: RadioOptionStore<Option>
    var value: Option
    let label: () -> Label
    
    public init(
        value: Option,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.value = value
        self.label = label
    }
    
    public var body: some View {
        let binding = Binding<Bool>(
            get: {
                self.store.selectedOption == value
            },
            set: { isSelected in
                if isSelected {
                    self.store.selectedOption = value
                }
            }
        )
        
        return Toggle(isOn: binding, label: label)
    }
}
