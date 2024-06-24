//
//  ButtonBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import RxSwift
import RxCocoa

final class ButtonBookViewController: BaseViewController<ButtonBookView> {
    // MARK: Setup methods
    override func setupBind() {
        super.setupBind()
        baseView.setupBind()
        
        Observable.combineLatest(
            baseView.variantControl.rx.selectedSegmentIndex,
            baseView.sizeControl.rx.selectedSegmentIndex,
            baseView.shapeControl.rx.selectedSegmentIndex,
            baseView.stateControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.baseView.buttons.enumerated().forEach { index, button in
                button.styled(
                    variant: BasicButtonVariant.allCases[value.0],
                    color: BasicButtonColor.allCases[index],
                    size: BasicButtonSize.allCases[value.1],
                    shape: BasicButtonShape.allCases[value.2]
                )
                button.isEnabled = value.3 == 0
            }
        })
        .disposed(by: disposeBag)
    }
}
