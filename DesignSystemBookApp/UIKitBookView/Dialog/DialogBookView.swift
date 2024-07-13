//
//  DialogBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import RxCocoa
import Then
import SnapKit

final class DialogBookView: BaseView {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    let variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    let variantControl = UISegmentedControl(
        items: Array(BasicDialogVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    let shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    let shapeControl = UISegmentedControl(
        items: Array(BasicDialogShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let dialogOpenButton = BaseButton(
        itemBuilder: {
            [
                UILabel().then {
                    $0.text = "open dialog"
                    $0.setTypo(.body1)
                }
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .secondary, size: .small)
    }
    
    // dialog
    let dialog = BaseDialog(
        title: "Dialog title",
        subTitle: "This is a sub title"
    )
    
    let dialogCloseButton = BaseButton(
        itemBuilder: {
            [
                UILabel().then {
                    $0.text = "close"
                    $0.setTypo(.body1)
                }
            ]
        }
    ).then {
        $0.styled(
            variant: .translucent,
            color: .secondary,
            size: .medium
        )
    }
    
    override func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(dialogOpenButton)

        dialog.addContent(dialogCloseButton)
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(pagePadding)
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
}
