//
//  DialogFigureTheme.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/3/24.
//

import Foundation

protocol DialogFigureTheme {
    func padding() -> GapOffset
    func shape() -> AnyShape
    func rounded() -> RoundedOffset
}
