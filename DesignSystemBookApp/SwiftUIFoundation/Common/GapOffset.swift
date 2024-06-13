//
//  LayoutSize.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import Foundation

struct GapOffset {
    let vertical: CGFloat?
    let horizontal: CGFloat?
    
    init(
        _ vertical: CGFloat?,
        _ horizontal: CGFloat?
    ) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
    
    init(all: CGFloat) {
        self.vertical = all
        self.horizontal = all
    }
}
