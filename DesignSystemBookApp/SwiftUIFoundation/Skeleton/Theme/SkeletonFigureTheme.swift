//
//  SkeletonFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

protocol SkeletonFigureTheme {
    func rounded() -> RoundedOffset
    func shape() -> AnyShape?
}
