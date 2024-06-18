//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then
import RxSwift

public class BaseButton: UIControl {
    // MARK: Theme
    var colorTheme: ButtonColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    var figureTheme: ButtonFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
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
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "Button"
        $0.setTypo(.body1)
        $0.textAlignment = .center
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateTheme()
        setupHierachy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateTheme()
        setupHierachy()
        setupLayout()
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
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupLayout() {
        guard let figureTheme = figureTheme
        else { return }
        
        let padding = figureTheme.padding()
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.width.lessThanOrEqualToSuperview().inset(padding.horizontal ?? 0)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupBind() {
    }
    
    // MARK: Update
    private func updateTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        backgroundColor = colorTheme.backgroundColor(state: getState(.enabled)).uiColor
        clipsToBounds = true
        layer.borderColor = colorTheme.borderColor(state: getState(.enabled)).cgColor
        layer.borderWidth = figureTheme.borderWidth()
        
        titleLabel.setTypo(figureTheme.typo())
        titleLabel.textColor = colorTheme.foregroundColor(state: getState(.enabled)).uiColor
        
        updateCornerRadius()
        
        stackView.arrangedSubviews
            .filter { $0 is UIImageView }
            .forEach {
                $0.tintColor = colorTheme.foregroundColor(state: getState(.enabled)).uiColor
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
        
        let padding = figureTheme.padding()
        
        stackView.snp.removeConstraints()
        stackView.snp.updateConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.width.lessThanOrEqualToSuperview().inset(padding.horizontal ?? 0)
            $0.centerX.equalToSuperview()
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
            options: [.curveEaseOut],
            animations: { [weak self] in
                guard let self = self else { return }
                guard let colorTheme = colorTheme else { return }
                self.backgroundColor = colorTheme.backgroundColor(state: self.getState(.enabled)).uiColor
                self.transform = .identity
            }
        )
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
}
