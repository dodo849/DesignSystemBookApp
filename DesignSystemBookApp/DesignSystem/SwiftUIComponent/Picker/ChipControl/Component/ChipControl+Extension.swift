//
//  ChipControl+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

public extension ChipControl {
    func styled(
        variant: BasicChipVariant = .fillAndOutline,
        color: BasicChipColor = .primary,
        shape: BasicChipShape = .round
    ) -> some View {
        self.store.colorTheme = BasicChipColorTheme(
            variant: variant,
            color: color
        )
        self.store.figureTheme = BasicChipFigureTheme(shape: shape)
        return self
    }
}
