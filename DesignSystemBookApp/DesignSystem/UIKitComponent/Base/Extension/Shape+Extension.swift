//
//  Shape+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/12/24.
//

import UIKit

extension UIView {
    func clipShape(to path: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}

extension UIBezierPath {
    // Circle
    static func circle(in rect: CGRect) -> UIBezierPath {
        return UIBezierPath(ovalIn: rect)
    }
    
    // Capsule
    static func capsule(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2)
        return path
    }
    
    // Rounded Rectangle
    static func roundedRect(in rect: CGRect, cornerRadius: CGFloat) -> UIBezierPath {
        return UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
    }
}
