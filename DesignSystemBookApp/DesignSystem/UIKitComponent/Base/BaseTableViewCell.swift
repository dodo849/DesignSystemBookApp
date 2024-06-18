//
//  BasetupableViewCell.swift
//  UMC-Kitten-iOS
//
//  Created by DOYEON LEE on 1/30/24.
//

import UIKit

open class BaseTableViewCell: UITableViewCell, BaseViewProtocol {
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
    }

    open func setupHierarchy() { }
    
    open func setupLayout() { }
    
    open func setupBind() { }
}
