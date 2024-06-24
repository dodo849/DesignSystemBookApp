//
//  TextFieldBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import RxSwift
import RxCocoa

final class TextFieldBookViewController: BaseViewController<TextFieldBookView> {
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
//            owner.baseView.textField
//                .styled(
//                    variant: BasicTextFieldVariant.allCases[value.0],
//                    color: BasicTextFieldColor.allCases[0],
//                    size: BasicTextFieldSize.allCases[value.1],
//                    shape: BasicTextFieldShape.allCases[value.2]
//                )
            owner.baseView.textFields.enumerated().forEach { index, button in
                button.styled(
                    variant: BasicTextFieldVariant.allCases[value.0],
                    color: BasicTextFieldColor.allCases[index],
                    size: BasicTextFieldSize.allCases[value.1],
                    shape: BasicTextFieldShape.allCases[value.2]
                )
//                button.isEnabled = value.3 == 0
            }
        })
        .disposed(by: disposeBag)
    }
}
