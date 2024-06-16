//
//  TextFieldErrorMessage.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct TextFieldCaption<Label: View>: View {
    @Environment(\.textFieldState) private var state: TextFieldState
    
    private let content: () -> Label
    
    init(@ViewBuilder content: @escaping () -> Label) {
        self.content = content
    }
    
    init(_ message: String) where Label == Text {
        self.content = { Text(message) }
    }
    
    var body: some View {
        Group {
            if let text = content() as? Text {
                text
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(foregroundColor)
                    .font(.caption)
            } else {
                content()
                    .foregroundColor(foregroundColor)
                    .font(.caption)
            }
        }
        .opacity(state == .normal ? 0 : 1)
    }
    
    var foregroundColor: Color {
        switch state {
        case .normal: return .basicText.opacity(0)
        case .success: return .success
        case .error: return .destructive
        }
    }
}
