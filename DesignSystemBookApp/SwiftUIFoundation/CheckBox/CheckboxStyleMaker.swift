//
//  BaseCheckboxStyle.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct CheckboxStyleMaker: ToggleStyle {
    @GestureState private var isPressed = false
    
    let theme: CheckboxTheme
    let shape: CheckboxShape
    
    init(theme: CheckboxTheme, shape: CheckboxShape) {
        self.theme = theme
        self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let checkboxState: CheckboxState = configuration.isOn
        ? .checked
        : .unchecked
        
        HStack(alignment: .center) {
            checkboxImage(for: checkboxState)
            configuration.label
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(animation, value: isPressed)
        .gesture(dragGesture(configuration: configuration))
    }
    
    private var animation: Animation = {
        Animation.spring(response: 0.35)
    }()
    
    private func checkboxImage(for state: CheckboxState) -> some View {
        Image(systemName: "checkmark")
            .resizable()
            .frame(width: shape.imageSize, height: shape.imageSize)
            .padding(shape.boxPadding)
            .foregroundColor(theme.foregroundColor(state: state))
            .background(
                shapeView()
                    .fill(theme.backgroundColor(state: state))
            )
            .overlay(
                shapeView()
                    .stroke(theme.borderColor(state: state))
            )
    }
    
    private func shapeView() -> AnyShape {
        switch shape {
        case .square:
            return RoundedRectangle(cornerRadius: 0).asAnyShape()
        case .round:
            return RoundedRectangle(cornerRadius: 4).asAnyShape()
        case .circle:
            return Circle().asAnyShape()
        }
    }
    
    private func dragGesture(configuration: Configuration) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                withAnimation {
                    state = true
                }
            }
            .onEnded { _ in
                withAnimation(animation) {
                    configuration.isOn.toggle()
                }
            }
    }
    
}
