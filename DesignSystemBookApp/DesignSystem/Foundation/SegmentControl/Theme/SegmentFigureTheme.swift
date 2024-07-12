//
//  SegmentFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol SegmentFigureTheme {
    func shape() -> AnyShape
    func containerRounded() -> RoundedOffset
    func containerPadding() -> GapOffset
    func itemRounded() -> RoundedOffset
    func itemPadding() -> GapOffset
    func itemSpacing() -> GapOffset
    func indicatorHeight() -> CGFloat? // for underline
}
