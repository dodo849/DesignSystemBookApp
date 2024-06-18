//
//  SwiftPrimitive+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

public extension String {
    static var empty: String {
        return ""
    }
}

public extension Int {
    static var zero: Int {
        return 0
    }
}

public extension Double {
    static var zero: Double {
        return 0
    }
}

public extension CGFloat {
    static var zero: CGFloat {
        return 0
    }
    
    /// A component can have a maximum width, which is the screen width.
    static var infinityWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// A component can have a maximum height, which is the screen height.
    static var infinityHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

public extension Bool {
    static var `false`: Bool {
        return false
    }
}

public extension Float {
    static var zero: Float {
        return 0
    }
}

public extension Date {
    static var now: Date {
        return Date()
    }
}

public extension CGSize {
    static var zero: CGSize {
        return CGSize(width: 0, height: 0)
    }
}

public extension CGPoint {
    static var zero: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
}

// MARK: - SwiftUI
public extension Color {
    static var none: Color {
        return .basicBackground.opacity(0)
    }
}

public extension Shape {
    static var empty: any Shape {
        return EmptyShape()
    }
}

public extension View {
    var empty: any View {
        return EmptyView().asAnyView()
    }
}
