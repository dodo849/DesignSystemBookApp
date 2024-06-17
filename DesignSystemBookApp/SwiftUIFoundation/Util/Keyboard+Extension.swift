//
//  Keyboard+Extension.swift
//  Tokhand
//
//  Created by DOYEON LEE on 5/6/24.
//

import SwiftUI

extension View {
    func addHideKeyboardGesture() -> some View {
        self.onTapGesture {
            hideKeyboard()
        }
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
