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
            owner.baseView.textFields.enumerated().forEach { index, textField in
                textField.styled(
                    variant: BasicTextFieldVariant.allCases[value.0],
                    color: BasicTextFieldColor.allCases[index],
                    size: BasicTextFieldSize.allCases[value.1],
                    shape: BasicTextFieldShape.allCases[value.2],
                    state: owner.convertState(value.3)
                )
                textField.disabled = value.3 == 1
            }
            
            owner.baseView.textFieldWithAffix.styled(
                variant: BasicTextFieldVariant.allCases[value.0],
                color: .primary,
                size: BasicTextFieldSize.allCases[value.1],
                shape: BasicTextFieldShape.allCases[value.2],
                state: owner.convertState(value.3)
            )
            owner.baseView.textFieldWithAffix.disabled = value.3 == 1
            
            owner.baseView.textFieldWithOthers.styled(
                variant: BasicTextFieldVariant.allCases[value.0],
                color: .primary,
                size: BasicTextFieldSize.allCases[value.1],
                shape: BasicTextFieldShape.allCases[value.2],
                state: owner.convertState(value.3)
            )
            owner.baseView.textFieldWithOthers.disabled = value.3 == 1
        })
        .disposed(by: disposeBag)
        
        baseView.textFieldWithAffix.onChange
            .withUnretained(self)
            .subscribe { owner, value in
                owner.baseView.textFieldSuffix.text = "\(value?.count ?? 0)/10"
            }
            .disposed(by: disposeBag)
    }
    
    func convertState(_ stateIndex: Int) -> TextFieldState {
        switch stateIndex {
        case 0:
            return TextFieldState.allCases[0]
        case 1:
            return .normal
        default:
            return TextFieldState.allCases[stateIndex - 1]
        }
    }
}
