//
//  AnyShape.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

extension Shape {
    func asAnyShape() -> AnyShape {
        AnyShape(self)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AnyShape: Shape {
    public var make: (CGRect, inout Path) -> ()

    public init(_ make: @escaping (CGRect, inout Path) -> ()) {
        self.make = make
    }

    public init<S: Shape>(_ shape: S) {
        self.make = { rect, path in
            path = shape.path(in: rect)
        }
    }

    public func path(in rect: CGRect) -> Path {
        return Path { [make] in make(rect, &$0) }
    }
}
