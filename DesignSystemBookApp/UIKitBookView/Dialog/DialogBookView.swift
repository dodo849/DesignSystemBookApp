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
    // MARK: UI component
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    lazy var variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    lazy var variantControl = UISegmentedControl(
        items: Array(BasicDialogVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    lazy var shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    lazy var shapeControl = UISegmentedControl(
        items: Array(BasicDialogShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    lazy var dialogOpenButton = BaseButton(
        contentsBuilder: {
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
    lazy var dialogCloseButton = BaseButton(
        contentsBuilder: {
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
    
    lazy var dialog = BaseDialog(
        contentsBuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [
                UILabel().then {
                    $0.text = "Dialog title"
                    $0.setTypo(.heading3)
                },
                UILabel().then {
                    $0.text = "This is a sub title"
                    $0.setTypo(.body1)
                },
                self.dialogCloseButton
            ]
        }
    )
    
    // MARK: Setup
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
                .inset(pagePadding)
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
