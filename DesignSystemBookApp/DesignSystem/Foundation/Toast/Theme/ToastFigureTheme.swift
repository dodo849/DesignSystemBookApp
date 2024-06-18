//
//  ToastFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import Foundation

protocol ToastFigureTheme {
    func rounded() -> RoundedOffset
    func shape() -> AnyShape
    func imageName() -> ImageName?
}
