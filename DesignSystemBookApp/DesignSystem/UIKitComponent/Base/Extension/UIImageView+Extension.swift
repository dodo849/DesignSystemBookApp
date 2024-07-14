//
//  ResizableImage.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import SnapKit

public extension UIImageView {
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            self.snp.makeConstraints {
                $0.width.equalTo(width)
            }
        }
        if let height = height {
            self.snp.makeConstraints {
                $0.height.equalTo(height)
            }
        }
    }
}
