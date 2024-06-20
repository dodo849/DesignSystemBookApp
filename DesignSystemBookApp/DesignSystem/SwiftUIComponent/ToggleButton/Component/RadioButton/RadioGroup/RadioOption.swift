//
//  RadioOption.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

/// A radio button used with `RadioGroup`.
///
/// ```swift
/// let selection: BasicToggleButtonColor = .primary
///
/// RadioGroup(
///     selection: $selection
/// ) {
///     ForEach(BasicToggleButtonColor.allCases, id: \.self) { color in
///         RadioOption(value: color) {
///             Text(color.rawValue)
///         }
///         .styled(
///             color: color,
///             shape: .circle
///         )
///     }
/// }
/// ```
///
/// - Important: `RadioOption` must be used as an internal view of `RadioGroup`.
public struct RadioOption<Label: View, Option: Identifiable & Equatable>: View, RadioButton {
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
