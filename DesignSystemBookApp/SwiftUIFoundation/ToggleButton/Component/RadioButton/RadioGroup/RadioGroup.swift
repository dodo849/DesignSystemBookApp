//
//  RadioButtonGroup.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

final class RadioOptionStore<Option: Identifiable & Equatable>: ObservableObject {
    @Published var selectedOption: Option? {
        didSet {
            if let selectedOption = selectedOption {
                onChange?(selectedOption)
            }
        }
    }
    
    var onChange: ((Option) -> Void)?

    init(selectedOption: Option? = nil, onChange: ((Option) -> Void)? = nil) {
        self.selectedOption = selectedOption
        self.onChange = onChange
    }
}

public struct RadioGroup<Content: View, Option: Identifiable & Equatable>: View {
    @StateObject var store: RadioOptionStore<Option>
    let content: () -> Content

    public init(
        defaultValue: Option? = nil,
        onChange: @escaping (Option) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._store = StateObject(
            wrappedValue:
                RadioOptionStore(
                    selectedOption: defaultValue,
                    onChange: onChange
                )
        )
        self.content = content
    }
    
    public var body: some View {
        Group {
            content()
        }.environmentObject(store)
    }
}
