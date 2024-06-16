//
//  SwiftPrimitive+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

extension String {
    static var empty: String {
        return ""
    }
}

extension Int {
    static var zero: Int {
        return 0
    }
}

extension Double {
    static var zero: Double {
        return 0
    }
}

extension CGFloat {
    static var zero: CGFloat {
        return 0
    }
}

extension Bool {
    static var `false`: Bool {
        return false
    }
}

extension Float {
    static var zero: Float {
        return 0
    }
}

extension Date {
    static var now: Date {
        return Date()
    }
}

extension CGSize {
    static var zero: CGSize {
        return CGSize(width: 0, height: 0)
    }
}

extension CGPoint {
    static var zero: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
}


// MARK: - SwiftUI
extension Color {
    static var none: Color {
        return .basicBackground.opacity(0)
    }
}

extension Shape {
    static var empty: any Shape {
        return EmptyShape()
    }
}

extension View {
    var empty: any View {
        return EmptyView().asAnyView()
    }
}
