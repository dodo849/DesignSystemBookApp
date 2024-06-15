//
//  TextFieldFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldFigureTheme {
    func padding() -> GapOffset
    func textSize() -> CGFloat
    func textWeight() -> Font.Weight
    func rounded() -> RoundedOffset
    func frame() -> FrameOffset
    func shape() -> AnyShape
}
