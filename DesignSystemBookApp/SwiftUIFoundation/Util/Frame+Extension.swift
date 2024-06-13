//
//  Frame+Extension.swift
//  arambyeol2023ver
//
//  Created by DOYEON LEE on 6/10/24.
//

import SwiftUI

enum FrameTarget {
    case width, height
}

extension View {
    func frameMax(
        _ target: [FrameTarget] = [.width, .height],
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            maxWidth: target.contains(.width) ? .infinity : nil,
            maxHeight: target.contains(.height) ? .infinity : nil,
            alignment: alignment
        )
    }
}
