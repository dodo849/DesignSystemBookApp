//
//  Toast.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import SwiftUI

struct Toast: View {
    var message: String
    var colorTheme: ToastColorTheme
    var figureTheme: ToastFigureTheme
    
    var body: some View {
        HStack {
            image()
            Text(message)
                .typo(.body1b)
                .foregroundStyle(colorTheme.foregroundColor().color)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .foregroundStyle(colorTheme.foregroundColor().color)
        .background(colorTheme.backgroundColor().color)
        .background(.ultraThinMaterial)
        .clipShape(figureTheme.shape())
    }
    
    @ViewBuilder
    func image() -> some View {
        if let imageName = figureTheme.imageName() {
            switch imageName {
            case .system(let name):
                Image(systemName: name)
            case .asset(let name):
                Image(name)
                    .renderingMode(.template)
            }
        } else {
            EmptyView()
        }
    }
}
