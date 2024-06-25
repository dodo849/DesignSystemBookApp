//
//  ChipControl.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

public enum ChipControlOverflow {
    case wrap, scroll
}

public struct ChipControl<Content, Value>: View where Content: View, Value: Identifiable & Equatable {
    // Initial
    private var sources: [Value]
    private var content: (Value) -> Content
    
    // Theme
    @ObservedObject var store: PickerThemeStore
    
    // State
    @Binding private var selections: [Value]
    
    public init(
        _ sources: [Value],
        selections: Binding<[Value]>,
        multipleSelection: Bool = true,
        overflow: ChipControlOverflow = .wrap,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.sources = sources
        self._selections = selections
        self.content = content
        
        self._store = ObservedObject(wrappedValue: PickerThemeStore())
    }
    
    public var body: some View {
        let padding = store.figureTheme.containerPadding()
        let spacing = store.figureTheme.itemSpacing().horizontal ?? 0
        HStack(spacing: spacing) {
            ForEach(sources, id: \.id) { value in
                let selectState: PickerState = selections.contains(value) 
                ? .selected : .unselected
                
                content(value)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .typo(.body1b)
                    .foregroundStyle(
                        store.colorTheme.itemForegroundColor(
                            state: selectState
                        ).color
                    )
                    .background(
                        store.colorTheme.itemBackgroundColor(
                            state: selectState
                        ).color
                    )
                    .overlay {
                        store.figureTheme.shape()
                            .stroke(
                                store.colorTheme.itemBorderColor(state: selectState).color, 
                                lineWidth: 1
                            )
                    }
                    .clipShape(store.figureTheme.shape())
                    .onTapGesture {
                        if selections.contains(value) {
                            selections.removeAll { $0 == value }
                        } else {
                            selections.append(value)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.vertical, padding.vertical)
        .padding(.horizontal, padding.horizontal)
        .background(store.colorTheme.containerBackgroundColor().color)
        .clipShape(store.figureTheme.shape())
        .animation(.spring(response: 0.25), value: selections)
    }
}
