//
//  BaseTextField.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import Then
import RxSwift
import RxCocoa

public class BaseTextField: UIView {
    // MARK: Event emitter
    
    // MARK: Theme
    var colorTheme: TextFieldColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    var figureTheme: TextFieldFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    var state: TextFieldState = .normal {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: UI Components
    private let titleLabel = UILabel().then {
        $0.text = "Title"
        $0.setTypo(.body1)
        $0.textAlignment = .center
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private let textFieldContainer = UIView()
    
    private let textField = UITextField().then {
        $0.placeholder = "TextField"
        $0.textAlignment = .left
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateTheme()
        setupHierachy()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateTheme()
        setupHierachy()
        setupBind()
    }
    
    // MARK: Life cycle
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
        updateCornerRadius()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: Setup
    private func setupHierachy() {
        addSubview(titleLabel)
        addSubview(textFieldContainer)
        textFieldContainer.addSubview(textField)
    }
    
    private func setupBind() {
        textField.rx.controlEvent(.allEvents)
            .subscribe(
                onNext: { [weak self] in
                    self?.updateTheme()
                }
            )
            .disposed(by: disposeBag)
        
        let textFieldPaddingTapGesture = UITapGestureRecognizer()
        textFieldContainer.addGestureRecognizer(textFieldPaddingTapGesture)
        
        textFieldPaddingTapGesture.rx.event
            .bind { [weak self] _ in
                self?.textField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Update
    func updateTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            self.textFieldContainer.backgroundColor = colorTheme
                .backgroundColor(state: getState(.normal)).uiColor
            self.textFieldContainer.layer.borderColor = colorTheme
                .borderColor(state: getState(.normal)).cgColor
        }
        textFieldContainer.layer.borderWidth = figureTheme.borderWidth()
        updateCornerRadius()
        
        titleLabel.setTypo(.body1b)
        titleLabel.textColor = colorTheme.foregroundColor(state: getState(.normal)).uiColor
    }
    
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme
        else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? textFieldContainer.bounds.height / 2 : figureTheme.rounded().max
        
        textFieldContainer.clipsToBounds = true
        textFieldContainer.layer.cornerRadius = rounded
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme
        else { return }
        
        if superview != nil {
            self.snp.remakeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        let padding = figureTheme.padding()
        
        titleLabel.snp.remakeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        textFieldContainer.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        textField.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
    }
    
    // MARK: Delegate
    func focusTextField() {
        textField.becomeFirstResponder()
    }
    
    // MARK: Inner token
    func getState(_ state: TextFieldState) -> TextFieldAllState {
        if state == .error {
            return .error
        }
        
        if state == .success {
            return .success
        }
        
        if textField.isEditing {
            return .focused
        } else {
            return .normal
        }
    }
    
    var isFullWidth: Bool {
        figureTheme?.frame().width == .infinity
    }
}
