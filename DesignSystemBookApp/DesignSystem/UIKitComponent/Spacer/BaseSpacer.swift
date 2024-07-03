//
//  DSSapcer.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import UIKit

public final class BaseSpacer: UIView {
    enum Orientation {
        case vertical
        case horizontal
    }
    
    init(_ size: CGFloat = 0, orientation: Orientation = .vertical) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        self.snp.makeConstraints { make in
            switch orientation {
            case .vertical:
                make.width.equalTo(1)
                make.height.equalTo(size)
            case .horizontal:
                make.width.equalTo(size)
                make.height.equalTo(1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
