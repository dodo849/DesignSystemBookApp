//
//  ButtonBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

final class ButtonBookViewController: BaseViewController {
    // MARK: UI Components
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let stackContainer = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 15
    }
    
    let variantControlLabel = UILabel().then {
        $0.text = "Variant"
        $0.setTypo(.body1b)
    }
    
    let variantControl = UISegmentedControl(
        items: Array(BasicButtonVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let sizeControlLabel = UILabel().then {
        $0.text = "Size"
        $0.setTypo(.body1b)
    }
    
    let sizeControl = UISegmentedControl(
        items: Array(BasicButtonSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let shapeControlLabel = UILabel().then {
        $0.text = "Shape"
        $0.setTypo(.body1b)
    }
    
    let shapeControl = UISegmentedControl(
        items: Array(BasicButtonShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let divider = UIView().then {
        $0.backgroundColor = .gray02
    }
    
    let colorLabels: [UILabel] = BasicButtonColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .gray04
        }
    }
    
    let buttons: [DSButton] = BasicButtonColor.allCases.map { _ in
        DSButton().then {
            $0.styled()
        }
    }
    
    // MARK: Setup methods
    override func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackContainer)
        stackContainer.addArrangedSubview(sizeControlLabel)
        stackContainer.addArrangedSubview(sizeControl)
        stackContainer.addArrangedSubview(variantControlLabel)
        stackContainer.addArrangedSubview(variantControl)
        stackContainer.addArrangedSubview(shapeControlLabel)
        stackContainer.addArrangedSubview(shapeControl)
        stackContainer.addArrangedSubview(divider)
        stackContainer.addArrangedSubview(divider)
        buttons.enumerated().forEach { index, button in
            stackContainer.addArrangedSubview(colorLabels[index])
            stackContainer.addArrangedSubview(button)
        }
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        stackContainer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        // Set label to expand to maximum width
        sizeControlLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        sizeControlLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        // Button to take minimal space
        buttons[0].setContentHuggingPriority(.defaultLow, for: .horizontal)
        buttons[0].setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    override func setupBind() {
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            sizeControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.buttons.enumerated().forEach { index, button in
                button.styled(
                    variant: BasicButtonVariant.allCases[value.0],
                    color: BasicButtonColor.allCases[index],
                    size: BasicButtonSize.allCases[value.1],
                    shape: BasicButtonShape.allCases[value.2]
                )
            }
        })
        .disposed(by: disposeBag)
    }
}
