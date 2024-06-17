//
//  BaseViewController.swift
//  HumanscapeShoppingMall
//
//  Created by DOYEON LEE on 2023/05/30.
//

import UIKit
import RxSwift

protocol BaseViewControllerProtocol: AnyObject {
    func setupDelegate()
    func setupHierarchy()
    func setupLayout()
    func setupBind()
}

open class BaseViewController: UIViewController, BaseViewControllerProtocol {
    public var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    open func setupDelegate() { }
    
    open func setupHierarchy() { }
    
    open func setupLayout() { }
    
    open func setupBind() { }
}

public extension BaseViewController {
    func pushView(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    func pushWebView(_ url: URL) {
        let nextVC = WebViewController(url: url)
        nextVC.hidesBottomBarWhenPushed = true
        self.pushView(nextVC)
    }
    
    func backView(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}
