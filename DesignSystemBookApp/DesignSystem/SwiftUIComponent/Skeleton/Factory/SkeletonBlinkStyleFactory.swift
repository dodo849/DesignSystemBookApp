//
//  SkeletonBlinkModifier.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

// SkeletonBlinkStyleFactory
struct SkeletonBlinkStyleFactory: ViewModifier {
    var isActive: Bool = false
    private var figureTheme: SkeletonFigureTheme
    private var colorTheme: SkeletonColorTheme
    @State private var animatingTrigger = false
    
    init(
        isActive: Bool,
        figureTheme: SkeletonFigureTheme,
        colorTheme: SkeletonColorTheme
    ) {
        self.isActive = isActive
        self.figureTheme = figureTheme
        self.colorTheme = colorTheme
    }
    
    func body(content: Content) -> some View {
        content
            .frame(minHeight: figureTheme.rounded().max * 2)
            .overlay(backgroundOverlay())
            .overlay(shapeOverlay().opacity(isActive && animatingTrigger ? 0.3 : 1))
            .animation(
                isActive
                ? .easeInOut(duration: 1).repeatForever(autoreverses: true)
                : nil,
                value: animatingTrigger
            )
            .id(isActive) // For stop animation
            .onAppear {
                if isActive {
                    animatingTrigger.toggle()
                }
            }
            .onChange(of: isActive) { isActiveValue in
                if isActiveValue {
                    animatingTrigger.toggle()
                }
            }
    }
}

extension SkeletonBlinkStyleFactory {
    private func shapeOverlay() -> some View {
        Group {
            if let shape = figureTheme.shape() {
                shape
                    .fill(colorTheme.backgroundColor())
            }
        }
    }
    
    private func backgroundOverlay() -> some View {
        Group {
            if let shape = figureTheme.shape() {
                shape
                    .fill(.basicBackground)
            }
        }
    }
}
