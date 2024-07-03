//
//  BaseDialog.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

public extension BaseDialog {
    func addContent(_ content: UIView) {
        self.contentStackView.addArrangedSubview(content)
    }
    
    func open() {
        let duration = 0.3
        self.isHidden = false
        self.overlayView.alpha = 0
        self.dialogBackground.alpha = 0
        
        UIView.animate(withDuration: duration) {
            self.overlayView.alpha = 1
            self.dialogBackground.alpha = 1
        }
    }
    
    func close() {
        let duration = 0.3
        UIView.animate(withDuration: duration) {
            self.overlayView.alpha = 0
            self.dialogBackground.alpha = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.isHidden = true
            }
        }
    }
}

public class BaseDialog: UIView {
    // MARK: Theme
    
    // MARK: UIConstant
    private let backgroundPadding: CGFloat = 16
    private let pagePadding: CGFloat = 24
    
    // MARK: UI Component
    private let overlayView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    private let dialogBackground = UIView().then {
        $0.backgroundColor = .basicBackground
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.setTypo(.body0b)
    }
    
    private let subTitleLabel = UILabel().then {
        $0.setTypo(.body1)
        $0.textColor = .gray06
    }
    
//    public var content: [BaseDialogContent<UIView>] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        updateCornerRadius()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateCornerRadius()
        updateTheme()
        updateLayout()
    }
    
    public convenience init(
        title: String = "",
        subTitle: String = ""
    ) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        self.isHidden = true
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierachy() { 
        addSubview(overlayView)
        addSubview(dialogBackground)
        dialogBackground.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subTitleLabel)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        dialogBackground.layer.cornerRadius = 16
    }
    
    private func updateTheme() { }
    
    private func updateLayout() { 
        overlayView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
            $0.edges.equalToSuperview()
        }
        
        dialogBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(pagePadding)
        }
        
        contentStackView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(backgroundPadding)
            $0.bottom.equalTo(dialogBackground.snp.bottom).inset(backgroundPadding)
        }
    }
}
