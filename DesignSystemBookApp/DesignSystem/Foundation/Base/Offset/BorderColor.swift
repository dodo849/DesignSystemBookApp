//
//  BorderColor.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/12/24.
//

import Foundation

struct BorderColor {
    let top: UniversalColor
    let bottom: UniversalColor
    let left: UniversalColor
    let right: UniversalColor
    
    init(
        top: UniversalColor = .init(.clear),
        bottom: UniversalColor = .init(.clear),
        left: UniversalColor = .init(.clear),
        right: UniversalColor = .init(.clear)
    ) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    init(all: UniversalColor) {
        self.top = all
        self.bottom = all
        self.left = all
        self.right = all
    }
    
    var all: UniversalColor {
        if top.color == bottom.color 
            && bottom.color == left.color
            && left.color == right.color {
            return top
        } else {
            fatalError("Not all border colors are the same")
        }
    }
}
