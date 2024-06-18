//
//  BasicToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

struct BasicToastFigureTheme: ToastFigureTheme {
    private let variant: ToastVariant
    private let _shape: ToastShape
    
    init(
        variant: ToastVariant,
        shape: ToastShape
    ) {
        self.variant = variant
        self._shape = shape
    }
    
    func rounded() -> RoundedOffset {
        switch _shape {
        case .round: return .large
        case .square: return .xsmall
        case .pill: return .infinity
        }
    }
    
    func shape() -> AnyShape {
        switch _shape {
        case .round:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .square:
            let round = rounded()
            return RoundedRectangle(cornerRadius: round.max).asAnyShape()
        case .pill:
            return Capsule().asAnyShape()
        }
    }
    
    func imageName() -> ImageName? {
        switch variant {
        case .success: return .system("checkmark.circle")
        case .warning: return .system("exclamationmark.triangle")
        case .error: return .system("exclamationmark.circle.fill")
        case .info: return nil
        }
    }
}
