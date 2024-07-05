//
//  DialogViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import RxSwift

final class DialogBookViewController: BaseViewController<DialogBookView> {
    override func setupBind() {
        super.setupBind()
        baseView.setupBind()
        
        baseView.dialogOpenButton.onTap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.baseView.dialog.open()
            })
            .disposed(by: disposeBag)
        
        baseView.dialogCloseButton.onTap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.baseView.dialog.close()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            baseView.variantControl.rx.selectedSegmentIndex,
            baseView.shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.baseView.dialog.styled(
                variant: .allCases[value.0],
                shape: .allCases[value.1]
            )
        })
        .disposed(by: disposeBag)
    }
}
