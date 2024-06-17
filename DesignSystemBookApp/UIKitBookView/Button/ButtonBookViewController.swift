//
//  ButtonBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then
import SnapKit

class ButtonBookViewController: BaseViewController {
    let button = BasicButton()

    open override func setupHierarchy() {
        view.addSubview(button)
    }
    
    open override func setupLayout() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    open override func setupBind() { 
        
    }

}
