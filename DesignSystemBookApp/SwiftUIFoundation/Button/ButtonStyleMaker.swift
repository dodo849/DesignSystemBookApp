//
//  BaseButtonStyle.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonStyleMaker: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let theme: ButtonTheme
    let size: ButtonSize
    let shape: ButtonShape
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let buttonState = state(configuration: configuration)
        
        configuration.label
            .padding(.vertical, size.padding.vertical)
            .padding(.horizontal, size.padding.horizontal)
            .frame(maxWidth: size.width)
            .background(backgroundColor( configuration, buttonState))
            .clipShape(shapeView())
            .overlay(border(configuration, buttonState))
            .foregroundColor(foregroundColor(configuration, buttonState))
            .font(.system(size: size.textSize))
            .fontWeight(size.textWeight)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.35), value: configuration.isPressed)
    }
    
    private func backgroundColor(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> some View {
        theme.backgroundColor(state: configuration.isPressed ? .pressed : state)
    }
    
    private func border(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> some View {
        shapeView()
            .stroke(theme.borderColor(state: state), lineWidth: 1)
    }
    
    private func foregroundColor(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> Color {
        theme.foregroundColor(state: state)
    }
    
    private func shapeView() -> AnyShape {
        switch shape {
        case .square:
            return RoundedRectangle(cornerRadius: 0).asAnyShape()
        case .round:
            return RoundedRectangle(cornerRadius: size.rounded).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
    
    private func state(configuration: Self.Configuration) -> ButtonState {
        if !isEnabled {
            return .disabled
        }
        
        if configuration.isPressed {
            return .pressed
        }
        
        return .enabled
    }
}
