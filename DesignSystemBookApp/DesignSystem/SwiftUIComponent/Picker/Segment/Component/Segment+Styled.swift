//
//  SegmentExtension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/20/24.
//

import SwiftUI

public extension Segment {
    func styled(
        color: BasicSegmentColor = .primary,
        shape: BasicSegmentShape = .round
    ) -> some View {
        self.store.colorTheme = BasicSegmentColorTheme(color: color)
        self.store.figureTheme = BasicSegmentFigureTheme(shape: shape)
        return self
    }
}
