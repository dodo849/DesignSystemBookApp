//
//  BasicSkeletonColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct BasicSkeletonColorTheme: SkeletonColorTheme {
    private let state: SkeletonState
    
    init(state: SkeletonState) {
        self.state = state
    }
    
    func backgroundColor() -> Color {
        switch state {
        case .loading: return .gray02
        case .complete: return .clear
        }
    }
}
