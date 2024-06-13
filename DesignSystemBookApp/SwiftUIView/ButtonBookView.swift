//
//  ButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonBookView: View {
    private var colors = ButtonColor.allCases
    @State private var selectedVariant =  ButtonVariant.allCases.first!
    private var variants = ButtonVariant.allCases
    @State private var selectedSize = ButtonSize.allCases.first!
    private var sizes = ButtonSize.allCases
    @State private var selectedShape = ButtonShape.allCases.first!
    var sahpes = ButtonShape.allCases
    @State private var selectedState = "disabled"
    // "pressed" is contained in enabled
    private var states = ["enabled", "disabled"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("variant")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("state")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a shape", selection: $selectedState) {
                    ForEach(states, id: \.self) {
                        Text($0)
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
                
                Divider()
                ForEach(colors, id: \.self) { color in
                    Text(color.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    Button {
                        let generatedCode = generateCode(color.rawValue)
                        ClipboardHelper.copyToClipboard(text: generatedCode)
                        printGeneratedCode(generatedCode)
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Button")
                        }
                    }
                    .styled(
                        variant: selectedVariant,
                        color: color,
                        size: selectedSize,
                        shape: selectedShape
                    )
                    .disabled(selectedState == "disabled")
                }
                
                Spacer().frame(height: 15)
                
                Button {
                    let generatedCode = generateCode("primary")
                    ClipboardHelper.copyToClipboard(text: generatedCode)
                    printGeneratedCode(generatedCode)
                } label: {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text("Copy Code")
                    }
                }
                .styled(
                    variant: .transparent,
                    size: .small,
                    shape: .pill
                )
            }
            .padding()
        }
    }
    
    private func generateCode(_ color: String) -> String {
        let variantString = selectedVariant.rawValue == "fill"
        ? ""
        : "variant: .\(selectedVariant)"
        
        let colorString = color == "primary"
        ? ""
        : "color: .\(color)"
        
        let sizeString = selectedSize.rawValue == "large"
        ? ""
        : "size: .\(selectedSize)"
        
        let shapeString = selectedShape.rawValue == "round"
        ? ""
        : "shape: .\(selectedShape)"
        
        let disabledString = selectedState == "enabled"
        ? ""
        : "\n.disabled(true)"
        
        let components = [variantString, colorString, sizeString, shapeString]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
        
        let styledString = """
        Button {
        } label: {
        }
        .styled(\(components))\(disabledString)
        """
        return styledString
    }
    
    private func printGeneratedCode(_ code: String) {
        print(
            """
            <Copy/Paste Code>
            Generated code has been copied to your clipboard.
            ---
            \(code)
            """
        )
        print("Generated code has been copied to your clipboard.")
    }
    
}

#Preview {
    ButtonBookView()
}
