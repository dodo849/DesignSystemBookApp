//
//  RadioButtonGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

final class RadioOptionStore<Option: Identifiable & Equatable>: ObservableObject {
    @Published var selectedOption: Option?

    init(selectedOption: Option? = nil) {
        self.selectedOption = selectedOption
    }
}

/// A group that contains radio options as internal views, 
/// ensuring that only one option can be selected at a time.
///
/// ```swift
/// let defaultColor: BasicToggleButtonColor? = nil // Use this if you want no initial selection
///
/// RadioGroup(
///     defaultValue: defaultColor,
///     onChange: { _ in }
/// ) {
///     ForEach(colors, id: \.self) { (option: BasicToggleButtonColor) in
///         RadioOption(value: option) {
///             Text(option.rawValue)
///         }
///         .styled(
///             color: .primary,
///             shape: .circle
///         )
///     }
/// }
/// ```
///
/// - Important: `RadioOption` must be used as an internal view of `RadioGroup`.
public struct RadioGroup<Content: View, Option: Identifiable & Equatable>: View {
    @StateObject private var store: RadioOptionStore<Option>
//    private var sources: [Option]
//    @Binding private var selection: Option?
    let content: () -> Content

    public init(
//        sources: [Option],
        selection: Option?,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._store = StateObject(
            wrappedValue:
                RadioOptionStore(
                    selectedOption: selection
                )
        )
//        self.sources = sources
//        self._selection = selection
        self.content = content
    }
    
    public var body: some View {
        Group {
//            ForEach(sources, id: \.id) { option in
                content()
//            }
        }
        .environmentObject(store)
    }
}
