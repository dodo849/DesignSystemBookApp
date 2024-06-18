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
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    let variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    let variantControl = UISegmentedControl(
        items: Array(BasicButtonVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let sizeControlLabel = UILabel().then {
        $0.text = "size"
        $0.setTypo(.body1b)
    }
    
    let sizeControl = UISegmentedControl(
        items: Array(BasicButtonSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    let shapeControl = UISegmentedControl(
        items: Array(BasicButtonShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let stateControlLabel = UILabel().then {
        $0.text = "state"
        $0.setTypo(.body1b)
    }
    
    let stateControl = UISegmentedControl(
        items: ["enabled", "disabled"]
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
    
    let buttons: [BaseButton] = BasicButtonColor.allCases.map { _ in
        BaseButton().then {
            $0.styled()
            $0.setImage(systemName: "square.and.arrow.up")
        }
    }
    
    // MARK: Setup methods
    override func setupHierarchy() {
        view.backgroundColor = .basicBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(stackContainer)
        
        stackContainer.addArrangedSubview(sizeControlLabel)
        stackContainer.addArrangedSubview(sizeControl)
        stackContainer.addArrangedSubview(variantControlLabel)
        stackContainer.addArrangedSubview(variantControl)
        stackContainer.addArrangedSubview(shapeControlLabel)
        stackContainer.addArrangedSubview(shapeControl)
        stackContainer.addArrangedSubview(stateControlLabel)
        stackContainer.addArrangedSubview(stateControl)
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
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.greaterThanOrEqualTo(view.snp.left).inset(pagePadding)
            $0.right.lessThanOrEqualTo(view.snp.right).inset(pagePadding)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        sizeControl.snp.makeConstraints {
            $0.width.equalTo(stackContainer.snp.width)
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackContainer.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackContainer.snp.width)
        }
        
        stateControl.snp.makeConstraints {
            $0.width.equalTo(stackContainer.snp.width)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(stackContainer.snp.width)
        }
        
        buttons.forEach { button in
            button.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }
    
    func updateLayout() {
        if sizeControl.selectedSegmentIndex == 0 {
            buttons.forEach { button in
                button.snp.updateConstraints {
                    $0.width.equalToSuperview()
                }
            }
        } else {
            buttons.forEach { button in
                button.snp.removeConstraints()
            }
        }
    }
    
    override func setupBind() {
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            sizeControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex,
            stateControl.rx.selectedSegmentIndex
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
                button.isEnabled = value.3 == 0
            }
            owner.updateLayout()
        })
        .disposed(by: disposeBag)
    }
}
