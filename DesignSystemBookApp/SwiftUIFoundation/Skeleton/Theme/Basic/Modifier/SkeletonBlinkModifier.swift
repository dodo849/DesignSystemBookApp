//
//  SkeletonBlinkModifier.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct SkeletonBlinkModifier: ViewModifier {
    var isActive: Bool = false
    @State private var animatingTrigger = false
    
    init(isActive: Bool) {
        self.isActive = isActive
        print(isActive)
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isActive && animatingTrigger ? 0.3 : 1)
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
