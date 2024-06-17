//
//  ButtonBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then
import SnapKit

final class ButtonBookViewController: BaseViewController {
    let button = DSButton().styled()

    override func setupHierarchy() {
        view.addSubview(button)
    }
    
    override func setupLayout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupBind() {
        
    }

}
