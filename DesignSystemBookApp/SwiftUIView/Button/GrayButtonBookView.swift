//
//  GrayButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//
import SwiftUI

struct GrayButtonBookView: View {
    private var colors = GrayButtonColor.allCases
    @State private var selectedVariant =  BasicButtonVariant.allCases.first!
    private var variants = BasicButtonVariant.allCases
    @State private var selectedSize = BasicButtonSize.allCases.first!
    private var sizes = BasicButtonSize.allCases
    @State private var selectedShape = BasicButtonShape.allCases.first!
    var sahpes = BasicButtonShape.allCases
    @State private var selectedState = "enabled"
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
            <#Action#>
        } label: {
            <#Label#>
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
    BasicButtonBookView()
}
