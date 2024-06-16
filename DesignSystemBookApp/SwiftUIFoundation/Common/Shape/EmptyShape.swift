//
//  EmptyShape.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/16/24.
//

import SwiftUI

struct EmptyShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path()
    }
}
