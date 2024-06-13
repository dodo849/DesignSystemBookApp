//
//  BaseCheckButtonStyle.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ToggleButtonStyleMaker: ToggleStyle {
    @GestureState private var isPressed = false
    
    let theme: ToggleButtonTheme
    let shape: ToggleButtonShape
    let innerImage: Image?
    
    init(
        theme: ToggleButtonTheme,
        shape: ToggleButtonShape,
        innerImage: Image? = nil
    ) {
        self.theme = theme
        self.shape = shape
        self.innerImage = innerImage
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let toggleButtonState: ToggleButtonState = configuration.isOn
        ? .checked
        : .unchecked
        
        HStack(alignment: .center) {
            styledImage(for: toggleButtonState)
            configuration.label
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(animation, value: isPressed)
        .gesture(dragGesture(configuration: configuration))
    }
    
    private var animation: Animation = {
        Animation.spring(response: 0.35)
    }()
    
    private func styledImage(for state: ToggleButtonState) -> some View {
        guard let image = innerImage else {
            return EmptyView().asAnyView()
        }
        
        let styledImage = image
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
        
        return styledImage.asAnyView()
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
