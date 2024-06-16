//
//  Keyboard+Extension.swift
//  Tokhand
//
//  Created by DOYEON LEE on 5/6/24.
//

import SwiftUI

extension View {
    func addHideKeyboardGuesture() -> some View {
        let tapGesture = TapGesture().onEnded {
            hideKeyboard()
        }
        return self.simultaneousGesture(tapGesture)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
