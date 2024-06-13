//
//  CheckButtonView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct CheckButtonBookView: View {
    @State var isOn: [Bool] = [false, false, false]
    @State var selectedColor = ToggleButtonColor.allCases.first!
    var colors = ToggleButtonColor.allCases
    @State var selectedShape =  ToggleButtonShape.allCases.first!
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
                
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    Text(color.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    
                    CheckboxButton(isOn: $isOn[index]) {
                        Text("Click me")
                    }
                    .styled(
                        color: selectedColor,
                        shape: selectedShape
                    )
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    CheckButtonBookView()
}
