//
//  Divider+View.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

public final class BaseDivider: UIView {
    public enum Orientation {
        case vertical
        case horizontal
    }
    
    public init(
        color: UIColor = .lightGray.withAlphaComponent(0.3),
        thickness: CGFloat = 1,
        orientation: Orientation = .horizontal
    ) {
        super.init(frame: .zero)
        self.backgroundColor = color
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        
        self.snp.makeConstraints {
            switch orientation {
            case .vertical:
                $0.width.equalTo(thickness)
            case .horizontal:
                $0.width.equalTo(windowScene.screen.bounds.width).priority(.low)
                $0.height.equalTo(thickness)
            }
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
