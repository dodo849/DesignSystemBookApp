//
//  DialogViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

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
    }
}
