//
//  TextFieldView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa

final class TextFieldBookView: BaseView {
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    let sizeControlLabel = UILabel().then {
        $0.text = "size"
        $0.setTypo(.body1b)
    }
    
    let sizeControl = UISegmentedControl(
        items: Array(BasicTextFieldSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    let variantControl = UISegmentedControl(
        items: Array(BasicTextFieldVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    let shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    let shapeControl = UISegmentedControl(
        items: Array(BasicTextFieldShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let stateControlLabel = UILabel().then {
        $0.text = "state"
        $0.setTypo(.body1b)
    }
    
    let stateControl = UISegmentedControl(
        items: ["normal", "disabled", "error", "success"]
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let colorLabels: [UILabel] = BasicTextFieldColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .gray04
        }
    }
    
    let textFields: [BaseTextField] = BasicTextFieldColor.allCases.map { _ in
        BaseTextField().then {
            $0.styled()
        }
    }
    
    let textFieldWithAffixLabel = UILabel().then {
        $0.text = "With Affix"
        $0.setTypo(.body0b)
    }
    
    let textFieldSuffix = UILabel().then {
        $0.text = "0/10"
        $0.setTypo(.body1)
        $0.textColor = .gray05
    }
    
    let textFieldWithAffix = BaseTextField().then {
        let prefix = UIImageView(
            image: UIImage(systemName: "square.and.pencil")
        ).then {
            $0.tintColor = .gray05
        }
        $0.addPrefix(prefix)
        $0.styled()
    }
    
    let textFieldWithOthersLabel = UILabel().then {
        $0.text = "With Others"
        $0.setTypo(.body0b)
    }
    
    let textFieldWithOthers = BaseTextField().then {
        let title = UILabel().then {
            $0.text = "Title"
            $0.setTypo(.body1b)
            $0.textColor = .basicText
        }
        let description = UILabel().then {
            $0.text = "Description"
            $0.setTypo(.body3)
            $0.textColor = .gray04
        }
        $0.addTitle(title)
        $0.addDescription(description)
        $0.styled()
    }

    override func setupBind() {
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
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
        stackView.addArrangedSubview(UIView.makeDivider())
        
        textFields.enumerated().forEach { index, textField in
            stackView.addArrangedSubview(colorLabels[index])
            stackView.addArrangedSubview(textField)
        }
        stackView.addArrangedSubview(UIView.makeDivider())
        stackView.addArrangedSubview(textFieldWithAffixLabel)
        stackView.addArrangedSubview(textFieldWithAffix)
        stackView.addArrangedSubview(textFieldWithOthersLabel)
        stackView.addArrangedSubview(textFieldWithOthers)
        
        textFieldWithAffix.addSuffix(textFieldSuffix)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(stackView.snp.height).offset(30)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(pagePadding)
            $0.centerX.equalToSuperview()
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
    }
}
