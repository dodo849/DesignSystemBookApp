//
//  ButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonBookView: View {
    var colors = ["primary", "secondary", "tertiary", "destructive"]
    @State var selectedVariant = "fill"
    var variants = ["fill", "outline", "translucent"]
    @State var selectedSize = "large"
    var sizes = ["large", "medium", "small"]    
    @State var selectedShape = "quare"
    var sahpes = ["quare", "round", "smapillll"]    
    @State var selectedState = "enabled"
    var states = ["enabled", "disabled", "pressed"]
    
    var body: some View {
        VStack(spacing: 18) {
            Text("variant")
                .font(.system(size: 16, weight: .semibold))
            Picker("Choose a variant", selection: $selectedVariant) {
                ForEach(variants, id: \.self) {
                    Text($0)
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
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            Text("shape")
                .font(.system(size: 16, weight: .semibold))
            Picker("Choose a shape", selection: $selectedShape) {
                ForEach(sahpes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            Divider()
            ForEach(colors, id: \.self) { color in
                Button {
                    print("호에엥")
                } label: {
                    Text("무아앙")
                }
                .styled(
                    variant: ButtonVariant(rawValue: selectedVariant)!,
                    state: ButtonState(rawValue: selectedState)!, 
                    color: ButtonColor(rawValue: color)!,
                    size: ButtonSize(rawValue: selectedSize)!
                )
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ButtonBookView()
}
