//
//  TextFieldContainer.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct TextFieldContainer<Content: View>: View {
    private let content: () -> Content
    private let state: TextFieldState
    
    init(
        state: TextFieldState,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.state = state
    }
    
    var body: some View {
        content()
            .environment(\.textFieldState, state)
    }
}
