//
//  DSButton+Extension.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import UIKit

public extension BaseButton {
    func styled(
        variant: BasicButtonVariant = .fill,
        color: BasicButtonColor = .primary,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) {
        let colorTheme = BasicButtonColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicButtonFigureTheme(
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public extension BaseButton {
    func setImage(
        imageView: UIView,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        _setImage(imageView: imageView)
    }
    
    func setImage(
        systemName: String,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        let image = UIImage(systemName: systemName)
        let imageView = UIImageView(image: image)
        
        _setImage(imageView: imageView)
    }
    
    func setImage(
        assetName: String,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        guard let image = UIImage(named: assetName) else {
            print("Image not found")
            return
        }
        
        let imageView = UIImageView(image: image)
        
        _setImage(imageView: imageView)
    }
    
    private func _setImage(
        imageView: UIView,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        imageView.tintColor = colorTheme?
            .foregroundColor(state: getState(.enabled)).uiColor
        imageView.contentMode = .scaleAspectFit
        
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach { $0.removeFromSuperview() }
        
        switch alignment {
        case .leading:
            stackView.insertArrangedSubview(imageView, at: 0)
        case .trailing:
            stackView.addArrangedSubview(imageView)
        }
    }
}

public enum BaseButtonImageAlignment {
    case leading
    case trailing
}
