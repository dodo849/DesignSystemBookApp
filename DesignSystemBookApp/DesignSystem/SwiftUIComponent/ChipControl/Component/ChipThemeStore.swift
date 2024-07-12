//
//  ChipThemeStore.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/13/24.
//

import Foundation

class ChipThemeStore: ObservableObject {
    @Published var colorTheme: ChipColorTheme
    @Published var figureTheme: ChipFigureTheme
    
    init() {
        self.colorTheme = BasicChipColorTheme(
            variant: .deepAndSoft,
            color: .primary
        )
        self.figureTheme = BasicChipFigureTheme(
            shape: .round
        )
    }
}
