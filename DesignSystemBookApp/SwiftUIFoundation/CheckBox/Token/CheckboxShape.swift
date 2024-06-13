//
//  CheckboxShape.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/13/24.
//

import Foundation

public enum CheckboxShape: String {
    case round, square, circle
    
    var imageSize: CGFloat {
        switch self {
        case .round: return 12
        case .square: return 12
        case .circle: return 10
        }
    }
    
    var boxPadding: CGFloat {
        switch self {
        case .round: return 4
        case .square: return 4
        case .circle: return 5
        }
    }
}
