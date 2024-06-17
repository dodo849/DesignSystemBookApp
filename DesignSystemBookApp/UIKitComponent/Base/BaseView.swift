//
//  BaseView.swift
//  HumanscapeShoppingMall
//
//  Created by DOYEON LEE on 2023/05/30.
//

import UIKit

import RxSwift

protocol BaseViewProtocol {
    func setupHierarchy()
    func setupLayout()
    func setupBind()
}

open class BaseView: UIView, BaseViewProtocol {
    var disposeBag = DisposeBag()
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
        setupBind()
    }

    open func setupHierarchy() { }
    
    open func setupLayout() { }
    
    open func setupBind() { }
}

