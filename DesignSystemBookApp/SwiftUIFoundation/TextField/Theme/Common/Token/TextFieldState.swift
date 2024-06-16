//
//  TextFieldState.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

public enum TextFieldState: String, CaseIterable {
    case normal, success, error
}

struct TextFieldStateKey: EnvironmentKey {
    static let defaultValue: TextFieldState = .normal
}

extension EnvironmentValues {
    var textFieldState: TextFieldState {
        get { self[TextFieldStateKey.self] }
        set { self[TextFieldStateKey.self] = newValue }
    }
}
