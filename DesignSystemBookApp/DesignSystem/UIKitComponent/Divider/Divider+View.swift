//
//  Divider+View.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

extension UIView {
    static func makeDivider(color: UIColor = .gray02, height: CGFloat = 1) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        return divider
    }
}
