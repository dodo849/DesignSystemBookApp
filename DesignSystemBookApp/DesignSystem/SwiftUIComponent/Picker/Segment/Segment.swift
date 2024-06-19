//
//  Segment.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

final class SegmentOptionStore<Option: Identifiable & Equatable>: ObservableObject {
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

struct SegmentGroup<Content, Option>: View where Content: View, Option: Identifiable & Equatable {
    @StateObject var store = SegmentOptionStore<Option>()
    private var content: () -> Content
    
    init(
        selection: Binding<Option>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._store = StateObject(
            wrappedValue: SegmentOptionStore<Option>(
                    selectedOption: selection.wrappedValue,
                    onChange: { selection.wrappedValue = $0 }
                )
        )
        self.content = content
    }
    
    var body: some View {
        HStack {
            content()
        }
        .padding()
        .background(.gray01)
        .environmentObject(store)
    }
}

struct SegmentOption<Option>: View where Option: Identifiable & Equatable {
    @EnvironmentObject var store: SegmentOptionStore<Option>
    private var value: Option
    private var label: () -> Text
    
    init(
        value: Option,
        @ViewBuilder label: @escaping () -> Text
    ) {
        self.value = value
        self.label = label
    }
    
    var body: some View {
        label()
            .padding()
            .background(store.selectedOption == value ? Color.blue : Color.clear)
            .foregroundColor(store.selectedOption == value ? .white : .black)
            .cornerRadius(8)
            .onTapGesture {
                store.selectedOption = value
            }
    }
}
