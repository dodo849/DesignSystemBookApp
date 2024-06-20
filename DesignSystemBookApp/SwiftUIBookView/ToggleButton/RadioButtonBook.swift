//
//  RadioButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

extension Int: Identifiable {
    public var id: Int { self }
}

struct RadioButtonBook: View {
    @State private var selectedColor = BasicToggleButtonColor.allCases.first!
    private var colors = BasicToggleButtonColor.allCases
    @State private var selectedShape = BasicToggleButtonShape.circle
    private var shapes = BasicToggleButtonShape.allCases
    
    // single
    @State private var isOn: [Bool] = [false, false, false]
    // group
    @State private var selections = BasicToggleButtonColor.allCases
    @State private var selection: BasicToggleButtonColor? = .primary
    
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
                    
                    SingleRadioButton(
                        isOn: Binding<Bool>(
                            get: { self.isOn[index] },
                            set: { newValue in
                                if newValue {
                                    for isOnIndex in isOn.indices {
                                        isOn[isOnIndex] = (isOnIndex == index)
                                    }
                                } else {
                                    isOn[index] = false
                                }
                            }
                        )
                    ) {
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
//                    sources: selections,
                    selection: selection
                ) {
                    ForEach(selections, id: \.id) { color in
                        RadioOption(value: color) {
                            Text("\(color.rawValue)")
                        }
                        .styled(
                            color: .primary,
                            shape: selectedShape
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    let generatedCode = generateGroupRadioCode(
                                        color.rawValue,
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
