//
//  SegmentColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol SegmentColorTheme {
    func itemForegroundColor(state: SegmentState) -> UniversalColor
    func indicatorBackgroundColor() -> UniversalColor
    func indicatorShadow() -> UniversalColor
    func containerBackgroundColor() -> UniversalColor
}
