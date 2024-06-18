//
//  BaseCollectionViewCell.swift
//  HumanscapeShoppingMall
//
//  Created by DOYEON LEE on 2023/05/30.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    open func setupHierarchy() { }
    
    open func setupLayout() { }
    
    open func setupBind() { }
}
