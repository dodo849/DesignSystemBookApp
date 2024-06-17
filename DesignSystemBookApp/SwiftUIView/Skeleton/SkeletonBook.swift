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
    @State private var selectedState: SkeletonState = .loading
    @State private var states: [SkeletonState] = SkeletonState.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                Text("variant")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Skeleton Variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("state")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Skeleton State", selection: $selectedState) {
                    ForEach(states, id: \.self) { state in
                        Text(state.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Text(selectedState == .loading ? "loading..." : "loaded")
                    .skeleton(
                        variant: selectedVariant,
                        state: selectedState
                    )
                    .padding(.vertical, 4)
                
                // MARK: With Shape
                
                Text("With Shape")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray02)
                    .frame(height: 100)
                    .skeleton(
                        variant: selectedVariant,
                        state: selectedState
                    )
                
                // MARK: Composition
                Text("Composition")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top)
                
                if selectedState == .loading {
                    HStack {
                        Circle()
                            .fill(.gray02)
                            .frame(height: 50)
                        VStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray02)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray02)
                                .frame(height: 20)
                        }
                    }
                    .skeleton(
                        variant: selectedVariant,
                        state: selectedState
                    )
                } else {
                    HStack {
                        Circle()
                            .fill(.gray02)
                            .frame(height: 50)
                        VStack(alignment: .leading) {
                            Text("User name")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(height: 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("user description")
                                .font(.system(size: 14))
                                .frame(height: 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
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
