//
//  ButtonTheme.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

protocol ButtonTheme {
    var variant: ButtonVariant { get }
    var color: ButtonColor { get }
    
    func backgroundColor(state: ButtonState) -> Color
    func borderColor(state: ButtonState) -> Color
    func foregroundColor(state: ButtonState) -> Color
}
