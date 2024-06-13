//
//  RadioButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct RadioButtonBookView: View {
    @State var isOn: [Bool] = [false, false, false]
    @State var selectedColor = ToggleButtonColor.allCases.first!
    var colors = ToggleButtonColor.allCases
    var defaultColor: ToggleButtonColor?
    @State var selectedShape = ToggleButtonShape.allCases.first!
    var shapes = ToggleButtonShape.allCases
    
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
                }
                
                Text("Group radio button")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                RadioGroup(
                    defaultValue: defaultColor,
                    onChange: { print($0) }
                ) {
                    ForEach(colors, id: \.self) { (option: ToggleButtonColor) in
                        RadioOption(value: option) {
                            Text(option.rawValue)
                        }
                        .styled(
                            color: option,
                            shape: selectedShape
                        )
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

extension ToggleButtonColor: Identifiable, Equatable {
    public var id: UUID {
        UUID()
    }
}

#Preview {
    CheckButtonBookView()
}
