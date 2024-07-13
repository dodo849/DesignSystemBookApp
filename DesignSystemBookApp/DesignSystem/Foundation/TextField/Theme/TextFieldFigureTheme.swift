//
//  TextFieldFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

protocol TextFieldFigureTheme {
    func padding() -> GapOffset
    func textSize() -> CGFloat // TODO: Typo로 묶기
    func textWeight() -> Font.Weight // TODO: Typo로 묶기
    func rounded() -> RoundedOffset
    func borderWidth() -> CGFloat
    func frame() -> FrameOffset
    func shape() -> AnyShape
}
