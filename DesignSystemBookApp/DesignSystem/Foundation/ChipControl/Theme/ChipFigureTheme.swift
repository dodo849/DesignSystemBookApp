//
//  ChipFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/13/24.
//

import Foundation

protocol ChipFigureTheme {
    func shape() -> AnyShape
    func containerRounded() -> RoundedOffset
    func containerPadding() -> GapOffset
    func itemRounded() -> RoundedOffset
    func itemPadding() -> GapOffset
    func itemSpacing() -> GapOffset
}
