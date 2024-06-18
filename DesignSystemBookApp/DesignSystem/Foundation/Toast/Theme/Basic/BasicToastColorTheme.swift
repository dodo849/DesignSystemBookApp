//
//  BasicToastColorTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import Foundation

struct BasicToastColorTheme: ToastColorTheme {
    private let variant: ToastVariant
    
    init(variant: ToastVariant) {
        self.variant = variant
    }
    
    func backgroundColor() -> ColorOffset {
        switch variant {
        case .success: return .init(.success.opacity(0.2))
        case .warning: return .init(.basicYellow.opacity(0.2))
        case .error: return .init(.destructive.opacity(0.2))
        case .info: return .init(.basicText.opacity(0.1))
        }
    }
    
    func foregroundColor() -> ColorOffset {
        switch variant {
        case .success: return .init(.success)
        case .warning: return .init(.basicYellow)
        case .error: return .init(.destructive)
        case .info: return .init(.basicText)
        }
    }
}
