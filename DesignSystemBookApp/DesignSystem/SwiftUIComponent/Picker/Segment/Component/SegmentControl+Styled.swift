//
//  SegmentExtension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/20/24.
//

import SwiftUI

public extension SegmentControl {
    func styled(
        variant: BasicSegmentVariant = .flat,
        color: BasicSegmentColor = .primary,
        shape: BasicSegmentShape = .round
    ) -> some View {
        self.store.colorTheme = BasicSegmentColorTheme(
            variant: variant,
            color: color
        )
        self.store.figureTheme = BasicSegmentFigureTheme(shape: shape)
        return self
    }
}
