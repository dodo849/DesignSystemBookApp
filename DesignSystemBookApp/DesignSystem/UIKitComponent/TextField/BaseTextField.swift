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

public extension BaseTextField {
    func styled(
        variant: BasicTextFieldVariant = .plain,
        color: BasicTextFieldColor = .primary,
        size: BasicTextFieldSize = .large,
        shape: BasicTextFieldShape = .round,
        state: TextFieldState = .normal
    ) {
        let colorTheme = BasicTextFieldColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicTextFieldFigureTheme(
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
        self.state = state
    }
}

public extension BaseTextField {
    func addTitle(_ view: UIView) {
        titleContainer.addArrangedSubview(view)
        layoutIfNeeded()
    }
    
    func addPrefix(_ view: UIView) {
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        textFieldContainer.insertArrangedSubview(view, at: 0)
        layoutIfNeeded()
    }
    
    func addSuffix(_ view: UIView) {
        textFieldContainer.addArrangedSubview(view)
        layoutIfNeeded()
    }
    
    func addDescription(_ view: UIView) {
        descriptionContainer.addArrangedSubview(view)
        layoutIfNeeded()
    }
}

public class BaseTextField: UIView {
    // MARK: Event emitter
    public let textFieldEvent = PublishSubject<UIControl.Event>()
    public let onChange = PublishSubject<String?>()
    
    // MARK: Theme
    private var colorTheme: TextFieldColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: TextFieldFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var state: TextFieldState = .normal {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    var disabled: Bool = false {
        didSet {
            textField.isEnabled = !disabled
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: UI Components
    private let titleContainer = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let descriptionContainer = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let textFieldBackground = UIView()
    
    private let textFieldContainer = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let textField = UITextField().then {
        $0.placeholder = "TextField"
        $0.textAlignment = .left
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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
        addSubview(titleContainer)
        addSubview(textFieldBackground)
        textFieldBackground.addSubview(textFieldContainer)
        textFieldContainer.addArrangedSubview(textField)
        addSubview(descriptionContainer)
    }
    
    private func setupBind() {
        textField.rx.controlEvent(.editingDidBegin)
            .map { UIControl.Event.editingDidBegin }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingChanged)
            .map { UIControl.Event.editingChanged }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingChanged)
            .map { [weak self] in self?.textField.text }
            .bind(to: onChange)
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd)
            .map { UIControl.Event.editingDidEnd }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .map { UIControl.Event.editingDidEndOnExit }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.allEvents)
            .subscribe(onNext: { [weak self] in
                self?.updateTheme()
            })
            .disposed(by: disposeBag)
        
        let textFieldPaddingTapGesture = UITapGestureRecognizer()
        textFieldBackground.addGestureRecognizer(textFieldPaddingTapGesture)
        
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
        
        updateCornerRadius()
        
        self.textFieldBackground.layer.borderColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            self.textFieldBackground.backgroundColor = colorTheme
                .backgroundColor(state: getState(state)).uiColor
            self.textFieldBackground.layer.borderColor = colorTheme
                .borderColor(state: getState(state)).cgColor
            self.textFieldBackground.layer.borderWidth = figureTheme.borderWidth()
            
            self.titleContainer.subviews.forEach { [weak self] in
                guard let self = self else { return }
                let color = colorTheme.foregroundColor(state: self.getState(self.state)).uiColor
                if let label = $0 as? UILabel {
                    label.textColor = color
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = color
                }
            }
            
            self.descriptionContainer.subviews.forEach { [weak self] in
                guard let self = self else { return }
                if let label = $0 as? UILabel {
                    label.textColor = descriptionColor
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = descriptionColor
                }
            }
            
        }
    }
    
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme
        else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? textFieldBackground.bounds.height / 2 : figureTheme.rounded().max
        
        textFieldBackground.clipsToBounds = true
        textFieldBackground.layer.cornerRadius = rounded
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
        
        titleContainer.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        textFieldBackground.snp.remakeConstraints {
            $0.top.equalTo(titleContainer.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        
        textFieldContainer.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
        
        descriptionContainer.snp.remakeConstraints {
            $0.top.equalTo(textFieldBackground.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    private func focusTextField() {
        textField.becomeFirstResponder()
    }
    
    // MARK: Inner token
    private func getState(_ state: TextFieldState) -> TextFieldAllState {
        if state == .error {
            return .error
        }
        
        if state == .success {
            return .success
        }
        
        if disabled {
            return .disabled
        }
        
        if textField.isEditing {
            return .focused
        } else {
            return .normal
        }
    }
    
    private var isFullWidth: Bool {
        figureTheme?.frame().width == .infinity
    }
    
    private var descriptionColor: UIColor {
        if state == .error {
            return .destructive
        }
        
        if state == .success {
            return .success
        }
        
        return .basicText.withAlphaComponent(0)
    }
}
