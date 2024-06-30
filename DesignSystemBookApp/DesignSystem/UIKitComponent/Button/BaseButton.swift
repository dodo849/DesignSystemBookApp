//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then
import RxSwift

public extension BaseButton {
    func styled(
        variant: BasicButtonVariant = .fill,
        color: BasicButtonColor = .primary,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) {
        let colorTheme = BasicButtonColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicButtonFigureTheme(
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public extension BaseButton {
    // MARK: Set label
    func setLabel(_ text: String) {
        titleLabel.text = text
    }
    
    // MARK: Set Image
    func setImage(
        imageView: UIView,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        _setImage(imageView: imageView)
    }
    
    func setImage(
        systemName: String,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        let image = UIImage(systemName: systemName)
        let imageView = UIImageView(image: image)
        
        _setImage(imageView: imageView)
    }
    
    func setImage(
        assetName: String,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        guard let image = UIImage(named: assetName) else {
            print("Image not found")
            return
        }
        
        let imageView = UIImageView(image: image)
        
        _setImage(imageView: imageView)
    }
    
    private func _setImage(
        imageView: UIView,
        alignment: BaseButtonImageAlignment = .leading
    ) {
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach { $0.removeFromSuperview() }
        
        switch alignment {
        case .leading:
            stackView.insertArrangedSubview(imageView, at: 0)
        case .trailing:
            stackView.addArrangedSubview(imageView)
        }
        
        updateTheme()
    }
}

public enum BaseButtonImageAlignment {
    case leading
    case trailing
}

public class BaseButton: UIControl {
    // MARK: Event emitter
    public var onTap: PublishSubject<Void> = PublishSubject()
    
    // MARK: Theme
    private var colorTheme: ButtonColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
            updateCornerRadius()
        }
    }
    private var figureTheme: ButtonFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
            updateCornerRadius()
        }
    }
    
    // MARK: Override button state
    override public var isEnabled: Bool {
        didSet {
            updateTheme()
        }
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: UI Components
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
        $0.isUserInteractionEnabled = false
    }
    
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.body1)
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = false
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
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
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    func updateTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        // Background
        backgroundColor = colorTheme.backgroundColor(state: getState(.enabled)).uiColor
        clipsToBounds = true
        layer.borderColor = colorTheme.borderColor(state: getState(.enabled)).cgColor
        layer.borderWidth = figureTheme.borderWidth()
        
        // Title label
        titleLabel.setTypo(figureTheme.typo())
        titleLabel.textColor = colorTheme.foregroundColor(state: getState(.enabled)).uiColor
        
        // Stack
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach {
                $0.tintColor = colorTheme.foregroundColor(state: getState(.enabled)).uiColor
                $0.contentMode = .scaleAspectFit
                $0.isUserInteractionEnabled = false
            }
    }
    
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme
        else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? bounds.height / 2 : figureTheme.rounded().max
        
        layer.cornerRadius = rounded
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme
        else { return }
        
        if superview != nil, isFullWidth {
            self.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
        } else {
            self.snp.removeConstraints()
        }
        
        let padding = figureTheme.padding()
        stackView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.centerX.equalToSuperview()
            // stackView가 button 양 옆을 당겨주는 레이아웃 full width일때는 self 제약을 우선하도록 설정
            $0.leading.trailing.equalToSuperview()
                .inset(padding.horizontal ?? 0)
                .priority(isFullWidth ? .low : .required)
        }
        
        let size = figureTheme.iconSize()
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach { image in
                image.snp.remakeConstraints {
                    $0.width.equalTo(size.width ?? 0)
                    $0.height.equalTo(size.height ?? 0)
                }
                image.setContentHuggingPriority(.defaultLow, for: .horizontal)
            }
    }
    
    // MARK: UIControl handling
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: [.transitionCrossDissolve],
            animations: { [weak self] in
                guard let self = self else { return }
                guard let colorTheme = colorTheme else { return }
                self.backgroundColor = colorTheme.backgroundColor(state: self.getState(.pressed)).uiColor
                self.transform = .init(scaleX: 0.9, y: 0.9)
            }
        )
        return true
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.transition(
            with: self,
            duration: 0.2,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }
                guard let colorTheme = colorTheme else { return }
                self.backgroundColor = colorTheme.backgroundColor(state: self.getState(.enabled)).uiColor
                self.transform = .identity
            }
        )
        onTap.onNext(())
        sendActions(for: .touchUpInside)
    }
    
    override public func cancelTracking(with event: UIEvent?) {
        guard let colorTheme = colorTheme
        else { return }
        
        backgroundColor = colorTheme.backgroundColor(state: getState(.enabled)).uiColor
    }
    
    // MARK: Inner token
    /// Determine the state considering isEnabled
    func getState(_ state: ButtonState) -> ButtonState {
        if isEnabled == true {
            return state
        } else {
            return .disabled
        }
    }
    
    var isFullWidth: Bool {
        figureTheme?.frame().width == .infinity
    }
}
