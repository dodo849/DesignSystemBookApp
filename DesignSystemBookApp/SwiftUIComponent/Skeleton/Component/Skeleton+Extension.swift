//
//  Skeleton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

public extension View {
    // 기본 스켈레톤 설정
    func skeleton(
        variant: SkeletonVariant = .blink,
        state: SkeletonState = .loading,
        shape: SkeletonShape = .round
    ) -> some View {
        let isAnimationActive: Bool = {
            switch state {
            case .loading: return true
            case .complete: return false
            }
        }()
        
        let figureTheme = BasicSkeletonFigureTheme(
            state: state,
            shape: shape
        )
        let colorTheme = BasicSkeletonColorTheme(state: state)
        
        switch variant {
        case .blink:
            let blinkStyle = SkeletonBlinkStyleFactory(
                isActive: isAnimationActive,
                figureTheme: figureTheme,
                colorTheme: colorTheme
            )
            return self
                .modifier(blinkStyle)
                .asAnyView()
            
        case .shining:
            let shiningStyle = SkeletonShiningStyleFactory(
                isActive: isAnimationActive,
                figureTheme: figureTheme,
                colorTheme: colorTheme
            )
            return self
                .modifier(shiningStyle)
                .asAnyView()
        }
    }
}
