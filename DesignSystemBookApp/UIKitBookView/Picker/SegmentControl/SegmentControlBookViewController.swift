//
//  SegmentControlViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import RxSwift

final class SegmentControlBookViewController: BaseViewController<SegmentControlBookView> {
    override func setupBind() {
        super.setupBind()
        baseView.setupBind()
        
        Observable.combineLatest(
            baseView.variantControl.rx.selectedSegmentIndex,
            baseView.colorControl.rx.selectedSegmentIndex,
            baseView.shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.baseView.segmentControl.styled(
                variant: BasicSegmentVariant.allCases[value.0],
                color: BasicSegmentColor.allCases[value.1],
                shape: BasicSegmentShape.allCases[value.2]
            )
        })
        .disposed(by: disposeBag)
    }
}
