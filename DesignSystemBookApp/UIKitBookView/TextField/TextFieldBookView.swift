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
    lazy var scrollView = UIScrollView()
    
    lazy var  contentView = UIView()
    
    lazy var  stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    lazy var sizeControlLabel = UILabel().then {
        $0.text = "size"
        $0.setTypo(.body1b)
    }
    
    lazy var sizeControl = UISegmentedControl(
        items: Array(BasicTextFieldSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    lazy var variantControl = UISegmentedControl(
        items: Array(BasicTextFieldVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    lazy var shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    lazy var shapeControl = UISegmentedControl(
        items: Array(BasicTextFieldShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var stateControlLabel = UILabel().then {
        $0.text = "state"
        $0.setTypo(.body1b)
    }
    
    lazy var stateControl = UISegmentedControl(
        items: ["normal", "disabled", "error", "success"]
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var colorLabels: [UILabel] = BasicTextFieldColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .gray04
        }
    }
    
    lazy var textFields: [BaseTextField] = BasicTextFieldColor.allCases.map { _ in
        BaseTextField().then {
            $0.styled()
        }
    }
    
    lazy var textFieldWithAffixLabel = UILabel().then {
        $0.text = "With Affix"
        $0.setTypo(.body1b)
    }
    
    lazy var textFieldSuffix = UILabel().then {
        $0.text = "0/10"
        $0.setTypo(.body1)
    }
    
    lazy var textFieldWithAffix = BaseTextField(
        prefixBuilder: {
            [
                UIImageView(
                    image: UIImage(systemName: "square.and.pencil")
                ).then {
                    $0.snp.makeConstraints {
                        $0.width.equalTo(20)
                    }
                }
            ]
        },
        suffixBuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [self.textFieldSuffix]
        }
    ).then {
        $0.styled()
    }
    
    lazy var textFieldWithOthersLabel = UILabel().then {
        $0.text = "With Others"
        $0.setTypo(.body1b)
    }
    
    lazy var textFieldWithOthers = BaseTextField(
        titleBuilder: {
            [
                UIImageView(
                    image: UIImage(systemName: "checkmark.circle")
                ).then {
                    $0.snp.makeConstraints {
                        $0.width.equalTo(20)
                    }
                },
                UILabel().then {
                    $0.text = "Title"
                    $0.setTypo(.body1b)
                    $0.textColor = .basicText
                }
            ]
        },
        descriptionBuilder: {
            [
                UIImageView(
                    image: UIImage(systemName: "exclamationmark.circle.fill")
                ).then {
                    $0.snp.makeConstraints {
                        $0.width.height.equalTo(15)
                    }
                },
                UILabel().then {
                    $0.text = "Description"
                    $0.setTypo(.body3)
                    $0.textColor = .gray04
                }
            ]
        }
    ).then {
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
        
        textFields.enumerated().forEach { index, textField in
            stackView.addArrangedSubview(colorLabels[index])
            stackView.addArrangedSubview(textField)
        }
//        stackView.addArrangedSubview(UIView.makeDivider())
        stackView.addArrangedSubview(textFieldWithAffixLabel)
        stackView.addArrangedSubview(textFieldWithAffix)
        stackView.addArrangedSubview(textFieldWithOthersLabel)
        stackView.addArrangedSubview(textFieldWithOthers)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(stackView.snp.height).offset(32)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
                .inset(pagePadding)
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
