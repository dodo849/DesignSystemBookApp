//
//  AnyView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

extension View {
    func asAnyView() -> AnyView {
        AnyView(self)
    }
}
