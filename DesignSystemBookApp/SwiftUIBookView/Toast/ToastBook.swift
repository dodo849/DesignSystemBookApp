//
//  ToastBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import SwiftUI

struct ToastBook: View {
    @State private var selectedVariant: ToastVariant = .info
    @State private var variants: [ToastVariant] = ToastVariant.allCases
    @State private var selectedShape: ToastShape = .round
    @State private var shapes: [ToastShape] = ToastShape.allCases
    @State private var selectedAlignment: ToastAlignment = .bottom
    @State private var alignments: [ToastAlignment] = ToastAlignment.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                Text("variant")
                    .typo(.body1b)
                Picker("Toast Variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("shape")
                    .typo(.body1b)
                Picker("Toast Shape", selection: $selectedShape) {
                    ForEach(shapes, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("alignment")
                    .typo(.body1b)
                Picker("Toast Shape", selection: $selectedAlignment) {
                    ForEach(alignments, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                
                Divider()
                    .padding()
                Button {
                    ToastManager.shared.showToast(
                        message: "Toast test",
                        variant: selectedVariant,
                        shape: selectedShape,
                        alignment: selectedAlignment,
                        duration: 2
                    )
                } label: {
                    Text("show toast")
                        .typo(.body1b)
                }
                .grayStyled(
                    variant: .outline,
                    color: .stone,
                    size: .medium
                )
            }
            .padding(pagePadding)
        }
        .background(.basicBackground)
    }
}

#Preview {
    ToastBook()
}
