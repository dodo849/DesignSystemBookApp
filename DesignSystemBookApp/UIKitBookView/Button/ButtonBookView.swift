//
//  ButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import Then
import SnapKit

final class ButtonBookView: BaseView {
    // MARK: UI Components
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    lazy var sizeControlLabel = UILabel().then {
        $0.text = "size"
        $0.setTypo(.body1b)
    }
    
    lazy var sizeControl = UISegmentedControl(
        items: Array(BasicButtonSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    lazy var variantControl = UISegmentedControl(
        items: Array(BasicButtonVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    lazy var shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    lazy var shapeControl = UISegmentedControl(
        items: Array(BasicButtonShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var stateControlLabel = UILabel().then {
        $0.text = "state"
        $0.setTypo(.body1b)
    }
    
    lazy var stateControl = UISegmentedControl(
        items: ["enabled", "disabled"]
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var divider = UIView().then {
        $0.backgroundColor = .gray02
    }
    
    lazy var colorLabels: [UILabel] = BasicButtonColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .gray04
        }
    }
    
    lazy var buttons: [BaseButton] = BasicButtonColor.allCases.map { _ in
        BaseButton(
            contentsBuilder: {
                [
                    UIImageView(
                        image: UIImage(systemName: "square.and.arrow.up")
                    ),
                    UILabel().then {
                        $0.text = "Button"
                        $0.setTypo(.body0b)
                    }
                ]
            }
        ).then {
            $0.styled()
        }
    }
    
    // MARK: Setup methods
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(sizeControlLabel)
        stackView.addArrangedSubview(sizeControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        stackView.addArrangedSubview(stateControlLabel)
        stackView.addArrangedSubview(stateControl)
        stackView.addArrangedSubview(divider)
        
        buttons.enumerated().forEach { index, button in
            stackView.addArrangedSubview(colorLabels[index])
            stackView.addArrangedSubview(button)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
                .inset(pagePadding)
            $0.left.right.equalToSuperview().inset(pagePadding)
            $0.centerX.equalTo(snp.centerX)
        }
        
        sizeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        stateControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(stackView.snp.width)
        }
        
        buttons.forEach { button in
            button.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }
}
