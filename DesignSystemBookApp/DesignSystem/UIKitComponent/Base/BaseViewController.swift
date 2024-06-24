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

open class BaseViewController<View: UIView>: UIViewController, BaseViewControllerProtocol {
    public var disposeBag = DisposeBag()
    
    public var baseView: View {
        return view as! View
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        view = View()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        
        view.backgroundColor = .basicBackground
        
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
