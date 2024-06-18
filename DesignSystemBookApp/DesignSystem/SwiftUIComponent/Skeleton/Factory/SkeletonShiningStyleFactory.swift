//
//  SkeletonShiningModifier.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct SkeletonShiningStyleFactory: ViewModifier {
    private var isActive: Bool = false
    private var figureTheme: SkeletonFigureTheme
    private var colorTheme: SkeletonColorTheme
    @State private var gradientPosition: CGFloat = -1.0
    
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
            .overlay(shapeOverlay())
            .overlay(gradientOverlay(content: content))
            .onAppear {
                if isActive {
                    startAnimating()
                }
            }
            .onChange(of: isActive) { isActiveValue in
                if isActiveValue {
                    startAnimating()
                } else {
                    stopAnimating()
                }
            }
    }
}

extension SkeletonShiningStyleFactory {
    private func shapeOverlay() -> some View {
        Group {
            if let shape = figureTheme.shape() {
                shape
                    .fill(colorTheme.backgroundColor())
            }
        }
    }
    
    private func gradientOverlay(content: Content) -> some View {
        GeometryReader { geometry in
            gradient
                .scaleEffect(x: 3, y: 1)
                .offset(x: gradientPosition * geometry.size.width * 2)
                .mask(
                    maskShape(
                        content: content,
                        height: geometry.size.height
                    )
                )
                .animation(
                    isActive
                    ? Animation
                        .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false)
                    : nil,
                    value: gradientPosition
                )
        }
    }
    
    private func startAnimating() {
        gradientPosition = 1.5
    }
    
    private func stopAnimating() {
        gradientPosition = -1.0
    }
}

extension SkeletonShiningStyleFactory {
    private func maskShape(
        content: Content,
        height: CGFloat
    ) -> some View {
        Group {
            if let shape = figureTheme.shape() {
                shape
            } else {
                content
                
            }
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.clear, Color.basicBackground.opacity(0.6), .clear]
            ),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
