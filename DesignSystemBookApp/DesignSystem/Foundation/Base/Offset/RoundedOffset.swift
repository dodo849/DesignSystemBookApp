//
//  RoundOffset.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import Foundation

struct RoundedOffset {
    var topLeftRadius: CGFloat
    var bottomLeftRadius: CGFloat
    var bottomRightRadius: CGFloat
    var topRightRadius: CGFloat
    
    init(
        topLeadingRadius: CGFloat = 0,
        bottomLeadingRadius: CGFloat = 0,
        bottomTrailingRadius: CGFloat = 0,
        topTrailingRadius: CGFloat = 0
    ) {
        self.topLeftRadius = topLeadingRadius
        self.bottomLeftRadius = bottomLeadingRadius
        self.bottomRightRadius = bottomTrailingRadius
        self.topRightRadius = topTrailingRadius
    }
    
    init(all: CGFloat) {
        self.topLeftRadius = all
        self.bottomLeftRadius = all
        self.bottomRightRadius = all
        self.topRightRadius = all
    }
}

extension RoundedOffset {
    var max: CGFloat {
        let maxValue = Swift.max(
            topLeftRadius,
            bottomLeftRadius,
            bottomRightRadius,
            topRightRadius
        )
        return maxValue
    }
    
    var min: CGFloat {
        let minValue = Swift.min(
            topLeftRadius,
            bottomLeftRadius,
            bottomRightRadius,
            topRightRadius
        )
        return minValue
    }
    
    var same: CGFloat {
        if topLeftRadius == bottomLeftRadius &&
            bottomLeftRadius == bottomRightRadius &&
            bottomRightRadius == topRightRadius {
            return topLeftRadius
        } else {
            fatalError("")
        }
    }
}
