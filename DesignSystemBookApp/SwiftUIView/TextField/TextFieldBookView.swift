//
//  TextFieldBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct TextFieldBookView: View {
    private var colors = BasicTextFieldColor.allCases
    @State private var selectedVariant = BasicTextFieldVariant.allCases.first!
    private var variants = BasicTextFieldVariant.allCases
    @State private var selectedSize = BasicTextFieldSize.allCases.first!
    private var sizes = BasicTextFieldSize.allCases
    @State private var selectedShape = BasicTextFieldShape.allCases.first!
    private var sahpes = BasicTextFieldShape.allCases
    @State private var selectedState = "normal"
    // Check `focus` state directly through the view
    private let states = ["normal", "disabled", "error", "success"]
    
    @State private var text: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("variant")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("size")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a szie", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("shape")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a shape", selection: $selectedShape) {
                    ForEach(sahpes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("state")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a state", selection: $selectedState) {
                    ForEach(states, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                
                ForEach(colors, id: \.self) { color in
                    Text(color.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    TextField("Placeholder", text: $text)
                        .styled(
                            variant: selectedVariant,
                            color: color,
                            size: selectedSize,
                            shape: selectedShape
                        )
                        .state(
                            selectedState != "disabled"
                            ? TextFieldState(rawValue: selectedState)!
                            : .normal
                        )
                        .disabled(selectedState == "disabled")
                }
            }
        }
        .padding()
    }
}

#Preview {
    TextFieldBookView()
}
