//
//  CardFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import Foundation

protocol CardFigureTheme {
    func padding() -> GapOffset
    func shape() -> AnyShape
    func rounded() -> RoundedOffset
}
