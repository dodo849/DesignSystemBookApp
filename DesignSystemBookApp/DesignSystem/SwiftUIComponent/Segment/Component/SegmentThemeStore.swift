//
//  PickerThemeStore.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

class SegmentThemeStore: ObservableObject {
    @Published var colorTheme: SegmentColorTheme
    @Published var figureTheme: SegmentFigureTheme
    
    init() {
        self.colorTheme = BasicSegmentColorTheme(
            variant: .flat,
            color: .primary
        )
        self.figureTheme = BasicSegmentFigureTheme(
            variant: .flat,
            shape: .round
        )
    }
}
