//
//  TextFieldBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct TextFieldBook: View {
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
    
    @State private var texts: [String] = Array(repeating: .empty, count: 8)
    
    // With message
    @State private var stateWithMessage: TextFieldState = .normal
    
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
                    .padding(.vertical)
                
                ForEach(Array(colors.enumerated()), id: \.element) { (index, color) in
                    Text(color.rawValue)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    TextField("Placeholder", text: $texts[index])
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
                
                // MARK: With affix
                Divider()
                    .padding(.vertical)
                
                Text("With affix")
                    .font(.system(size: 16, weight: .semibold))
                
                    TextField("Affix example", text: $texts[4])
                        .styled(
                            variant: selectedVariant,
                            color: .secondary,
                            size: selectedSize,
                            shape: selectedShape
                        )
                        .prefix {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.gray)
                        }
                        .suffix {
                            Text("\(texts[4].count)/10")
                                .foregroundColor(.gray)
                        }
                .state(
                    selectedState != "disabled"
                    ? TextFieldState(rawValue: selectedState)!
                    : .normal
                )
                .disabled(selectedState == "disabled")
                
                // MARK: With message
                Divider()
                    .padding(.vertical)
                
                Text("With message")
                    .font(.system(size: 16, weight: .semibold))
                
                TextFieldContainer(state: stateWithMessage) {
                    TextField("Message example", text: $texts[5])
                        .styled(
                            variant: selectedVariant,
                            color: .secondary,
                            size: selectedSize,
                            shape: selectedShape
                        )
                    TextFieldCaption("error or success description")
                }
                .state(
                    selectedState != "disabled"
                    ? TextFieldState(rawValue: selectedState)!
                    : .normal
                )
                .disabled(selectedState == "disabled")
                
                // MARK: With other components
                Divider()
                    .padding(.vertical)
                
                Text("With other components")
                    .font(.system(size: 16, weight: .semibold))
                
                TextFieldContainer(state: stateWithMessage) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Title")
                                .font(.system(size: 14, weight: .semibold))
                            if selectedState == "success" {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.success)
                            }
                        }
                        TextField("Message example", text: $texts[6])
                            .styled(
                                variant: selectedVariant,
                                color: .secondary,
                                size: selectedSize,
                                shape: selectedShape
                            )
                        TextFieldCaption {
                            HStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                Text("error or success description")
                            }
                        }
                    }
                }
                .state(
                    selectedState != "disabled"
                    ? TextFieldState(rawValue: selectedState)!
                    : .normal
                )
                .disabled(selectedState == "disabled")
            }
            .padding()
            .onChange(of: selectedState) { newValue in
                stateWithMessage = newValue != "disabled"
                ? TextFieldState(rawValue: newValue)!
                : .normal
            }
//            .addHideKeyboardGesture() // 넣으면 세그먼트가 터치가 안됨
        }
    }
}

#Preview {
    TextFieldBook()
}
