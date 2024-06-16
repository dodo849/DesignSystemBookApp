//
//  TextFieldAllState.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import Foundation

/// A state that the text field can have, including states that must be set using separate methods. 
/// For example, 'focused' and 'disabled'.
/// Therefore, it has an internal access control level.
enum TextFieldAllState: String, CaseIterable {
    case normal, focused, disabled, error, success
}
