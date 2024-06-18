//
//  ButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import SwiftUI

protocol ButtonFigureTheme {
    func padding() -> GapOffset
    func typo() -> Typo
    func rounded() -> RoundedOffset
    func borderWidth() -> CGFloat
    func frame() -> FrameOffset
    func shape() -> AnyShape
    // for uikit
    func iconSize() -> FrameOffset
}
