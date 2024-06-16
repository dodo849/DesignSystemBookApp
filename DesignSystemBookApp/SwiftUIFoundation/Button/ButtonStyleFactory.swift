//
//  ButtonStyleFactory.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ButtonStyleFactory: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorTheme: ButtonColorTheme
    private let figureTheme: ButtonFigureTheme
    
    init(
        colorTheme: ButtonColorTheme,
        figuretheme: ButtonFigureTheme
    ) {
        self.colorTheme = colorTheme
        self.figureTheme = figuretheme
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let state = makeState(configuration: configuration)
        let padding = figureTheme.padding()
        let textSize = figureTheme.textSize()
        let textWeight = figureTheme.textWeight()
        let frame = figureTheme.frame()
        
        configuration.label
            .padding(.vertical, padding.vertical)
            .padding(.horizontal, padding.horizontal)
            .frame(maxWidth: frame.width, maxHeight: frame.height)
            .background(backgroundColor(configuration, state))
            .clipShape(figureTheme.shape())
            .overlay(border(configuration, state))
            .foregroundColor(foregroundColor(configuration, state))
            .font(.system(size: textSize))
            .fontWeight(textWeight)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.35), value: configuration.isPressed)
    }
}
    
extension ButtonStyleFactory {
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
        figureTheme.shape()
            .stroke(
                colorTheme.borderColor(state: state),
                lineWidth: figureTheme.borderWidth()
            )
            .padding(figureTheme.borderWidth())
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
