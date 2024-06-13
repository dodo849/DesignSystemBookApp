//
//  ButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

protocol ButtonFigureTheme {
    func padding() -> LayoutSize
    func textSize() -> CGFloat
    func textWeight() -> Font.Weight
    func rounded() -> RoundedOffset
    func frame() -> LayoutSize
    func shape() -> AnyShape
}
