//
//  FrameOffset.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import Foundation

struct FrameOffset {
    let width: CGFloat?
    let height: CGFloat?
    
    init(
        _ width: CGFloat?,
        _ height: CGFloat?
    ) {
        self.width = width
        self.height = height
    }
    
    init(all: CGFloat?) {
        self.width = all
        self.height = all
    }
    
    var same: CGFloat? {
        if width == height {
            return width
        } else {
            fatalError("Width and height must be the same")
        }
    }
}
