//
//  Segment.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

public struct SegmentOption<Option>: View where Option: Identifiable & Equatable {
    @EnvironmentObject var store: SegmentStore<Option>
    private var value: Option
    private var label: () -> Text
    
    init(
        value: Option,
        @ViewBuilder label: @escaping () -> Text
    ) {
        self.value = value
        self.label = label
    }
    
    public var body: some View {
        let foregorundColor = store.colorTheme.foregroundColor(
            state: store.selectedOption == value
            ? .selected
            : .unselected
        ).color
        
        let backgroundColor = store.colorTheme.backgroundColor(
            state: store.selectedOption == value
            ? .selected
            : .unselected
        ).color
        
        let padding = store.figureTheme.itemPadding()
        
        return label()
//            .background(backgroundColor)
//            .foregroundColor(foregorundColor)
//            .clipShape(store.figureTheme.shape())
//            .onTapGesture {
//                    store.selectedOption = value
//            }
    }
}
