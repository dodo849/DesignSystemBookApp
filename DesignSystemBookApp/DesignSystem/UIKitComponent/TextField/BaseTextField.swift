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

/// Extension for set theme
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
            variant: variant,
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
        self.state = state
    }
}

public class BaseTextField: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Event
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
    
    // MARK: UI Component
    private let titleStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let descriptionStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let textFieldBackground = UIView()
    
    private let bottomBorder = UIView().then {
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    private let textFieldStack = UIStackView().then {
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
    
    // MARK: Builder
    private var titleBuilder: ViewBuilder = { [] }
    private var prefixBuilder: ViewBuilder = { []}
    private var suffixBuilder: ViewBuilder = { [] }
    private var descriptionBuilder: ViewBuilder = { [] }
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
        updateCornerRadius()
    }
    
    public init(
        titleBuilder: @escaping ViewBuilder = { [] },
        prefixBuilder: @escaping ViewBuilder = { [] },
        suffixBuilder: @escaping ViewBuilder = { [] },
        descriptionBuilder: @escaping ViewBuilder = { [] }
    ) {
        super.init(frame: .zero)
        
        self.titleBuilder = titleBuilder
        self.prefixBuilder = prefixBuilder
        self.suffixBuilder = suffixBuilder
        self.descriptionBuilder = descriptionBuilder
        
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    // MARK: Setup
    private func setupHierachy() {
        // titleStack
        addSubview(titleStack)
        titleBuilder().forEach {
            titleStack.addArrangedSubview($0)
        }
        
        addSubview(textFieldBackground)
        
        textFieldBackground.addSubview(textFieldStack)
        prefixBuilder().forEach {
            textFieldStack.addArrangedSubview($0)
        }
        textFieldStack.addArrangedSubview(textField)
        suffixBuilder().forEach {
            textFieldStack.addArrangedSubview($0)
        }
        
        addSubview(bottomBorder)
        
        addSubview(descriptionStack)
        descriptionBuilder().forEach {
            descriptionStack.addArrangedSubview($0)
        }
    }
    
    private func setupBind() {
        // Binding textfield event
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
        
        // Set padding as the touch target
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
        
        // Default set for animation
        self.textFieldBackground.layer.borderColor = UIColor.clear.cgColor
        let foregroundColor = colorTheme
            .foregroundColor(state: allState).uiColor
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            // TextField background
            self.textFieldBackground.backgroundColor = colorTheme
                .backgroundColor(state: allState).uiColor
            self.textFieldBackground.layer.borderColor = colorTheme
                .borderColor(state: allState).cgColor
            self.textFieldBackground.layer.borderWidth = figureTheme.borderWidth()
            
            // TextField
            self.textField.textColor = foregroundColor
            
            // Title stack
            self.titleStack.subviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor
                }
            }
            
            // TextField stack
            self.textFieldStack.subviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor.withAlphaComponent(0.6)
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor.withAlphaComponent(0.6)
                }
            }
            
            // Bottom border
            self.bottomBorder.backgroundColor = colorTheme
                .bottomBorderColor(state: allState).uiColor
            
            // descriptionStack
            self.descriptionStack.subviews.forEach { [weak self] in
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
        
        titleStack.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        textFieldBackground.snp.remakeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        
        textFieldStack.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
        
        bottomBorder.snp.remakeConstraints {
            $0.height.equalTo(2)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(textFieldBackground.snp.bottom)
        }
        
        descriptionStack.snp.remakeConstraints {
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
    private var allState: TextFieldAllState {
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
