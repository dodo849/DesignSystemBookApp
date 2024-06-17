//
//  ColorOffset.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit
import SwiftUI

struct ColorOffset {
    private let _color: UIColor
    
    init(_ color: Color) {
        self._color = UIColor(color)
    }
    
    init(uicolor: UIColor) {
        self._color = uicolor
    }
    
    init(cgcolor: CGColor) {
        self._color = UIColor(cgColor: cgcolor)
    }
    
    var color: Color {
        return Color(_color)
    }
    
    var uiColor: UIColor {
        return _color
    }
    
    var cgColor: CGColor {
        return _color.cgColor
    }
}
