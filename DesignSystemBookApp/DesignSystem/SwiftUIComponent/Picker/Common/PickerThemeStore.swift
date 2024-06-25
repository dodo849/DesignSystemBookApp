//
//  PickerThemeStore.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

class PickerThemeStore: ObservableObject {
    @Published var colorTheme: PickerColorTheme
    @Published var figureTheme: PickerFigureTheme
    
    init() {
        self.colorTheme = BasicSegmentColorTheme(
            variant: .flat,
            color: .primary
        )
        self.figureTheme = BasicSegmentFigureTheme(shape: .round)
    }
}
