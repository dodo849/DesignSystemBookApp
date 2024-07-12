//
//  ToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol PickerFigureTheme {
    func shape() -> AnyShape
    func containerRounded() -> RoundedOffset
    func containerPadding() -> GapOffset
    func itemRounded() -> RoundedOffset
    func itemPadding() -> GapOffset
    func itemSpacing() -> GapOffset
    func indicatorHeight() -> CGFloat? // for underline
}

extension PickerFigureTheme {
    func indicatorHeight() -> CGFloat? {
        return nil
    }
}
