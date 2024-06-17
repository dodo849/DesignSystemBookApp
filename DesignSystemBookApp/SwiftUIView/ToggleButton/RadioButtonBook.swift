//
//  RadioButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct RadioButtonBook: View {
    @State private var isOn: [Bool] = [false, false, false]
    @State private var selectedColor = BasicToggleButtonColor.allCases.first!
    private var colors = BasicToggleButtonColor.allCases
    private var defaultColor: BasicToggleButtonColor?
    @State private var selectedShape = BasicToggleButtonShape.allCases.first!
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
                Text("Single radio button")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    Text(color.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    
                    SingleRadioButton(isOn: $isOn[index]) {
                        Text("Click me")
                    }
                    .styled(
                        color: color,
                        shape: selectedShape
                    )
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded {
                                let generatedCode = generateRadioCode(
                                    color.rawValue,
                                    isOn: !isOn[index]
                                )
                                ClipboardHelper.copyToClipboard(text: generatedCode)
                                printGeneratedRadioCode(generatedCode)
                            }
                    )
                }
                
                Text("Group radio button")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                RadioGroup(
                    defaultValue: defaultColor,
                    onChange: { print($0) }
                ) {
                    ForEach(colors, id: \.self) { (option: BasicToggleButtonColor) in
                        RadioOption(value: option) {
                            Text(option.rawValue)
                        }
                        .styled(
                            color: option,
                            shape: selectedShape
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    let generatedCode = generateGroupRadioCode(
                                        option.rawValue,
                                        isOn: !isOn.contains(true)
                                    )
                                    ClipboardHelper.copyToClipboard(text: generatedCode)
                                    printGeneratedRadioCode(generatedCode)
                                }
                        )
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    private func generateRadioCode(_ color: String, isOn: Bool) -> String {
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
        SingleRadioButton(isOn: <#Binding<Bool>#>) {
        }
        .styled(\(components))
        """
        return styledString
    }
    
    private func generateGroupRadioCode(_ color: String, isOn: Bool) -> String {
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
        RadioGroup(
            defaultValue: <#Identifiable & Equatable#>,
            onChange: { _ in }
        ) {
            ForEach(<#Identifiable & Equatable#>, id: \\.self) { option in
                RadioOption(value: option) {
                }
                .styled(\(components))
            }
        }
        """
        return styledString
    }
    
    private func printGeneratedRadioCode(_ code: String) {
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

extension BasicToggleButtonColor: Identifiable, Equatable {
    public var id: UUID {
        UUID()
    }
}

#Preview {
    CheckButtonBook()
}
