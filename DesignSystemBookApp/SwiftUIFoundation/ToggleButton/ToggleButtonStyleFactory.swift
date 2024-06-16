//
//  ToggleButtonStyleFactory.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ToggleButtonStyleFactory: ToggleStyle {
    @GestureState private var isPressed = false
    
    private let colorTheme: ToggleButtonColorTheme
    private let figureTheme: ToggleButtonFigureTheme
    private let innerImage: Image?
    
    init(
        colorTheme: ToggleButtonColorTheme,
        figureTheme: ToggleButtonFigureTheme,
        innerImage: Image? = nil
    ) {
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
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
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(animation, value: isPressed)
        .gesture(dragGesture(configuration))
    }
    
    private var animation: Animation = {
        Animation.spring(response: 0.35)
    }()
    
    private func styledImage(for state: ToggleButtonState) -> some View {
        guard let image = innerImage else {
            return EmptyView().asAnyView()
        }
        
        let imageSize = figureTheme.innnerImageSize()
        let padding = figureTheme.padding()
        let shape = figureTheme.shape()
        
        let styledImage = image
            .resizable()
            .renderingMode(.template)
            .frame(width: imageSize.width, height: imageSize.height)
            .padding(.vertical, padding.vertical)
            .padding(.horizontal, padding.horizontal)
            .foregroundColor(colorTheme.foregroundColor(state: state))
            .background(
                shape
                    .fill(colorTheme.backgroundColor(state: state))
            )
            .overlay(
                shape
                    .stroke(colorTheme.borderColor(state: state))
            )
        
        return styledImage.asAnyView()
    }
    
    private func dragGesture(_ configuration: Configuration) -> some Gesture {
        let animation = SwiftUIAnimationFactory.startInteract.make
        
        return DragGesture(minimumDistance: 0)
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
