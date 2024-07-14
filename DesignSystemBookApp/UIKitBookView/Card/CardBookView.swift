//
//  CardBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import Then
import SnapKit
import RxCocoa

final class CardBookView: BaseView {
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    lazy var variantControlLabel = UILabel().then {
        $0.text = "Variant"
        $0.setTypo(.body1b)
    }
    
    lazy var variantControl = UISegmentedControl(
        items: Array(BasicCardVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var colorControlLabel = UILabel().then {
        $0.text = "Color"
        $0.setTypo(.body1b)
    }
    
    lazy var colorControl = UISegmentedControl(
        items: Array(BasicCardColor.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 3
    }

    lazy var shapeControlLabel = UILabel().then {
        $0.text = "Shape"
        $0.setTypo(.body1b)
    }
    
    lazy var shapeControl = UISegmentedControl(
        items: Array(BasicCardShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var paddingControlLabel = UILabel().then {
        $0.text = "Padding"
        $0.setTypo(.body1b)
    }
    
    lazy var paddingControl = UISegmentedControl(
        items: Array(BasicCardPadding.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 1
    }
    
    // card
    lazy var okButton = BaseButton(
        contentsBuilder:
                {
                    [
                        UILabel().then {
                            $0.text = "OK"
                            $0.setTypo(.body2)
                        }
                    ]
                }
        ).then {
            $0.grayStyled(color: .stone)
        }
    
    lazy var cancleButton = BaseButton(
        contentsBuilder:
                {
                    [
                        UILabel().then {
                            $0.text = "Cancle"
                            $0.setTypo(.body2)
                        }
                    ]
                }
        ).then {
            $0.grayStyled()
        }
    
    lazy var card = BaseCard(
        headerBuilder: {
            [
                UILabel().then {
                    $0.text = "Card"
                    $0.setTypo(.heading4)
                },
                UILabel().then {
                    $0.text = "This is a card"
                    $0.textColor = .gray05
                    $0.setTypo(.body1)
                }
            ]
        },
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "content section"
                    $0.setTypo(.body2)
                },
                UILabel().then {
                    $0.text = "Anything can be combined here: labels, text fields, images, and more."
                    $0.numberOfLines = 2
                    $0.setTypo(.body2)
                }
            ]
        },
        footerBuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [self.okButton, self.cancleButton]
        }
    ).then {
        $0.styled()
    }
    
    lazy var cardWidthImageLabel = UILabel().then {
        $0.text = "With image"
        $0.setTypo(.body1b)
    }
    
    lazy var cardWidthImage = BaseCard(
        contentsBuilder: {
            [
                UIImageView(image: .macBackground).then {
                    $0.setSize(height: 150)
                    $0.contentMode = .scaleToFill
                },
                UIView().then {
                    let titleLabel = UILabel().then {
                        $0.text = "Image card"
                        $0.setTypo(.heading4)
                    }
                    let descriptionLabel = UILabel().then {
                        $0.text = "This is a card with image"
                        $0.textColor = .gray05
                    }
                    
                    $0.addSubview(titleLabel)
                    $0.addSubview(descriptionLabel)
                    
                    titleLabel.snp.makeConstraints {
                        $0.top.equalToSuperview()
                        $0.leading.trailing.equalToSuperview().offset(16)
                    }
                    
                    descriptionLabel.snp.makeConstraints {
                        $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                        $0.leading.trailing.equalToSuperview().inset(16)
                        $0.bottom.equalToSuperview().inset(16)
                    }
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
        stackView.addArrangedSubview(colorControlLabel)
        stackView.addArrangedSubview(colorControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        stackView.addArrangedSubview(paddingControlLabel)
        stackView.addArrangedSubview(paddingControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(card)
        
        stackView.addArrangedSubview(cardWidthImageLabel)
        stackView.addArrangedSubview(cardWidthImage)
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
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        colorControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        paddingControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
}
