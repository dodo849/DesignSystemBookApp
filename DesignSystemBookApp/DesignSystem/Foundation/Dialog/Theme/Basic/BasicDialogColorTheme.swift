//
//  BasicDialogColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/3/24.
//

import Foundation

struct BasicDialogColorTheme: DialogColorTheme {
    private var variant: BasicDialogVariant
    
    init(variant: BasicDialogVariant) {
        self.variant = variant
    }
    
    func shadowColor() -> ColorOffset {
        switch variant {
        case .overlay: return .init(.clear)
        case .shadow: return .init(.black.opacity(0.2))
        }
    }
    
    func overlayColor() -> ColorOffset {
        switch variant {
        case .overlay: return .init(.black.opacity(0.2))
        case .shadow: return .init(.clear)
        }
    }
}
