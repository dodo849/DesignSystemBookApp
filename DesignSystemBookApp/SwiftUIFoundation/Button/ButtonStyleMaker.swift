//
//  BaseButtonStyle.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonStyleMaker: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let colorTheme: ButtonColorTheme
    let figuretheme: ButtonFigureTheme
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let state = makeState(configuration: configuration)
        let padding = figuretheme.padding()
        let textSize = figuretheme.textSize()
        let textWeight = figuretheme.textWeight()
        let frame = figuretheme.frame()
        
        configuration.label
            .padding(.vertical, padding.vertical)
            .padding(.horizontal, padding.horizontal)
            .frame(maxWidth: frame.width, maxHeight: frame.height)
            .background(backgroundColor( configuration, state))
            .clipShape(figuretheme.shape())
            .overlay(border(configuration, state))
            .foregroundColor(foregroundColor(configuration, state))
            .font(.system(size: textSize))
            .fontWeight(textWeight)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.35), value: configuration.isPressed)
    }
    
    private func backgroundColor(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> some View {
        colorTheme.backgroundColor(state: configuration.isPressed ? .pressed : state)
    }
    
    private func border(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> some View {
        figuretheme.shape()
            .stroke(colorTheme.borderColor(state: state), lineWidth: 1)
    }
    
    private func foregroundColor(
        _ configuration: Self.Configuration,
        _ state: ButtonState
    ) -> Color {
        colorTheme.foregroundColor(state: state)
    }
    
    private func makeState(configuration: Self.Configuration) -> ButtonState {
        if !isEnabled {
            return .disabled
        }
        
        if configuration.isPressed {
            return .pressed
        }
        
        return .enabled
    }
}
