//
//  ToggleButtonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/14/24.
//

import Foundation

protocol ToggleButtonFigureTheme {
    func innnerImageSize() -> FrameOffset
    func padding() -> GapOffset
    func shape() -> AnyShape
}
