//
//  SkeletonShiningModifier.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct SkeletonShiningModifier: ViewModifier {
    var isActive: Bool = false
    @State private var gradientPosition: CGFloat = -1.0
    
    init(isActive: Bool) {
        self.isActive = isActive
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geomery in
                    gradient
                        .scaleEffect(x: 3, y: 1)
                        .offset(x: gradientPosition * geomery.size.width * 2)
                        .animation(
                            isActive
                            ? Animation
                                .easeInOut(duration: 2)
                                .repeatForever(autoreverses: false)
                            : nil,
                            value: gradientPosition
                        )
                        .mask(content)
                }
            )
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
    
    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.clear, Color.basicBackground.opacity(0.6), .clear]
            ),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private func startAnimating() {
        gradientPosition = 1.5
    }
    
    private func stopAnimating() {
        gradientPosition = -1.0
    }
}
