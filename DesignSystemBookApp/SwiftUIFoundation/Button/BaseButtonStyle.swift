//
//  BaseButtonStyle.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    let theme: ButtonTheme
    let state: ButtonState
    let size: ButtonSize
    let shape: ButtonShape
    
    func makeBody(
        configuration: Self.Configuration
    ) -> some View {
        let isDisabled = state == .disabled
        
        configuration.label
            .padding(.vertical, size.padding.vertical)
            .padding(.horizontal, size.padding.horizontal)
            .frame(maxWidth: size.width)
            .background(
                theme.backgroundColor(
                    state: configuration.isPressed ? .pressed : state
                )
            )
            .clipShape(
                RoundedRectangle(cornerRadius: ButtonShape.roundRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: ButtonShape.roundRadius)
                    .stroke(theme.borderColor(state: state), lineWidth: 1)
            )
            .foregroundColor(theme.foregroundColor(state: state))
            .scaleEffect(
                configuration.isPressed ?
                CGFloat(0.9) :
                1.0
            )
            .animation(
                Animation.spring(
                    response: 0.35
                ),
                value: configuration.isPressed
            )
            .allowsHitTesting(!isDisabled)
    }
}
