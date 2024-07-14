//
//  CardBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import RxSwift
import RxCocoa

final class CardBookViewController: BaseViewController<CardBookView> {
    override func setupBind() {
        super.setupBind()
        baseView.setupBind()
        
        Observable.combineLatest(
            baseView.variantControl.rx.selectedSegmentIndex,
            baseView.colorControl.rx.selectedSegmentIndex,
            baseView.shapeControl.rx.selectedSegmentIndex,
            baseView.paddingControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.baseView.card.styled(
                variant: BasicCardVariant.allCases[value.0],
                color: BasicCardColor.allCases[value.1],
                shape: BasicCardShape.allCases[value.2],
                padding: BasicCardPadding.allCases[value.3]
            )
            
            owner.baseView.cardWidthImage.styled(
                variant: BasicCardVariant.allCases[value.0],
                color: BasicCardColor.allCases[value.1],
                shape: BasicCardShape.allCases[value.2],
                padding: BasicCardPadding.allCases[value.3]
            )
        })
        .disposed(by: disposeBag)
    }
}
