//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import RxSwift
import SnapKit
import Then

/// Extension for set theme
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
    
    func grayStyled(
        variant: BasicButtonVariant = .fill,
        color: GrayButtonColor = .ghost,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) {
        let colorTheme = GrayButtonColorTheme(
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

public class BaseButton: UIControl {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Event emitter
    public var _onTap: PublishSubject<Void> = PublishSubject()
    public var onTap: Observable<Void> {
        return _onTap.asObservable()
    }
    
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
    
    // MARK: UI Components
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: Build component
    private var contents: [UIView] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public init(
        contentsBuilder: ViewBuilder
    ) {
        super.init(frame: .zero)
        
        contents.append(contentsOf: contentsBuilder())
        
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierachy() {
        addSubview(stackView)
        
        contents.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    func updateTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        // color
        let backgroundColor = colorTheme.backgroundColor(state: getState(.enabled)).uiColor
        let borderColor = colorTheme.borderColor(state: getState(.enabled)).cgColor
        let foregroundColor = colorTheme.foregroundColor(state: getState(.enabled)).uiColor
        // figure
        let borderWidth = figureTheme.borderWidth()
        
        // Background
        self.backgroundColor = backgroundColor
        clipsToBounds = true
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth
        
        // Stack (items)
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach {
                $0.tintColor = foregroundColor
                $0.contentMode = .scaleAspectFit
                $0.isUserInteractionEnabled = false
            }
        
        stackView.arrangedSubviews
            .compactMap { $0 as? UILabel }
            .forEach {
                $0.textColor = foregroundColor
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
        _onTap.onNext(())
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
