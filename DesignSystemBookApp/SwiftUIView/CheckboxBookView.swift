//
//  CheckButtonView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct CheckButtonBookView: View {
    @State private var isOn: [Bool] = [false, false, false]
    @State private var selectedColor = BasicToggleButtonColor.allCases.first!
    private var colors = BasicToggleButtonColor.allCases
    @State private var selectedShape =  BasicToggleButtonShape.allCases.first!
    private var shapes = BasicToggleButtonShape.allCases
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Shape")
                    .font(.system(size: 16, weight: .semibold))
                Picker("Choose a shape", selection: $selectedShape) {
                    ForEach(shapes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    Text(color.rawValue)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.gray)
                    
                    CheckButton(isOn: $isOn[index]) {
                        Text("Click me")
                    }
                    .styled(
                        color: color,
                        shape: selectedShape
                    )
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded {
                                let generatedCode = generateCode(
                                    color.rawValue,
                                    isOn: !isOn[index]
                                )
                                ClipboardHelper.copyToClipboard(text: generatedCode)
                                printGeneratedCode(generatedCode)
                            }
                    )
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func generateCode(_ color: String, isOn: Bool) -> String {
        let colorString = color == "primary"
        ? ""
        : "color: .\(color)"
        
        let shapeString = selectedShape.rawValue == "round"
        ? ""
        : "shape: .\(selectedShape)"
        
        let components = [colorString, shapeString]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
        
        let styledString = """
        CheckboxButton(isOn: <#Binding<Bool>#>) {
        }
        .styled(\(components))
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
    CheckButtonBookView()
}
