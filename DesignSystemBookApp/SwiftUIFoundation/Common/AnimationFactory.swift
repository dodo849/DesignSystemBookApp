//
//  Animation.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/16/24.
//

import SwiftUI

enum AnimationFactory {
    case startInteract
    
    var make: Animation {
        switch self {
        case .startInteract:
            return Animation.spring(response: 0.35)
        }
    }
}
