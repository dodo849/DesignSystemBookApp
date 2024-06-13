//
//  LayoutSize.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import Foundation

struct LayoutSize {
    let vertical: CGFloat?
    let horizontal: CGFloat?
    
    init(
        _ vertical: CGFloat?,
        _ horizontal: CGFloat?
    ) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
}
