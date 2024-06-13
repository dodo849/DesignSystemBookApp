//
//  BaseButtonStyle.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonStyleMaker: ButtonStyle {
    let theme: ButtonTheme
    let state: ButtonState
    let size: ButtonSize
    let shape: ButtonShape
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let isDisabled = state == .disabled
        
        configuration.label
            .padding(.vertical, size.padding.vertical)
            .padding(.horizontal, size.padding.horizontal)
            .frame(maxWidth: size.width)
            .background(backgroundColor(configuration: configuration))
            .clipShape(shapeView())
            .overlay(border(configuration: configuration))
            .foregroundColor(foregroundColor(configuration: configuration))
            .font(.system(size: size.textSize))
            .fontWeight(size.textWeight)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.35), value: configuration.isPressed)
            .allowsHitTesting(!isDisabled)
    }
    
    private func backgroundColor(configuration: Self.Configuration) -> some View {
        theme.backgroundColor(state: configuration.isPressed ? .pressed : state)
    }
    
    private func border(configuration: Self.Configuration) -> some View {
        shapeView()
            .stroke(theme.borderColor(state: state), lineWidth: 1)
    }
    
    private func foregroundColor(configuration: Self.Configuration) -> Color {
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
}
