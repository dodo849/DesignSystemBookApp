//
//  Skeleton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

public extension View {
    func skeleton(
        variant: SkeletonVariant = .blink,
        state: SkeletonState = .loading
    ) -> some View {
        let isAnimationActive: Bool = {
            switch state {
            case .loading: return true
            case .complete: return false
            }
        }()
        
        switch variant {
        case .blink:
            return self
                .modifier(SkeletonBlinkModifier(isActive: isAnimationActive))
                .asAnyView()
        case .shining:
            return self
                .modifier(SkeletonShiningModifier(isActive: isAnimationActive))
                .asAnyView()
        }
    }
}
