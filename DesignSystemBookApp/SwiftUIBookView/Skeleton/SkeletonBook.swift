//
//  SkeletonBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct SkeletonBook: View {
    @State private var selectedVariant: SkeletonVariant = .blink
    @State private var variants: [SkeletonVariant] = SkeletonVariant.allCases
    @State private var selectedShape: SkeletonShape = .round
    @State private var shapes: [SkeletonShape] = SkeletonShape.allCases
    @State private var selectedState: SkeletonState = .loading
    @State private var states: [SkeletonState] = SkeletonState.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                Text("variant")
                    .typo(.body1b)
                Picker("Skeleton Variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("shape")
                    .typo(.body1b)
                Picker("Skeleton Shape", selection: $selectedShape) {
                    ForEach(shapes, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("state")
                    .typo(.body1b)
                Picker("Skeleton State", selection: $selectedState) {
                    ForEach(states, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                
                Text(selectedState == .loading ? "loading..." : "loaded")
                    .skeleton(
                        variant: selectedVariant,
                        state: selectedState,
                        shape: selectedShape
                    )
                    .padding(.vertical, 4)
                
                // MARK: Composition 
                Text("Composition")
                    .typo(.body1b)
                    .padding(.top)
                
                HStack {
                    Image("logo_padding")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                        .clipShape(.circle)
                        .skeleton(
                            variant: selectedVariant,
                            state: selectedState,
                            shape: .circle
                        )
                    VStack(alignment: .leading, spacing: 10) {
                        Text("User name")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .skeleton(
                                variant: selectedVariant,
                                state: selectedState,
                                shape: .pill
                            )
                        Text("user description")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .skeleton(
                                variant: selectedVariant,
                                state: selectedState,
                                shape: .pill
                            )
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SkeletonBook()
}
