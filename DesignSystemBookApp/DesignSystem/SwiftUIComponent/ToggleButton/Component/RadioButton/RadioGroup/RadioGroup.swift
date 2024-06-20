//
//  RadioButtonGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI
import Combine

final class RadioOptionStore<Option: Identifiable & Equatable>: ObservableObject {
    @Published var selectedOption: Option?
    
    init(selectedOption: Binding<Option?>) {
        self.selectedOption = selectedOption.wrappedValue
    }
}

/// A group that contains radio options as internal views,
/// ensuring that only one option can be selected at a time.
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
public struct RadioGroup<Content: View, Option: Identifiable & Equatable>: View {
    @StateObject private var store: RadioOptionStore<Option>
    @Binding var selection: Option?
    let content: () -> Content
    
    public init(
        selection: Binding<Option?>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._store = StateObject(
            wrappedValue:
                RadioOptionStore(
                    selectedOption: selection
                )
        )
        self._selection = selection
        self.content = content
    }
    
    public var body: some View {
        Group {
            content()
        }
        .environmentObject(store)
    }
}
