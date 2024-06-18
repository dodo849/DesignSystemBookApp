//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then

class DSButton: UIControl {
    // MARK: Theme
    var colorTheme: ButtonColorTheme? {
        didSet {
            setupTheme()
            updateLayout()
        }
    }
    var figureTheme: ButtonFigureTheme? {
        didSet {
            setupTheme()
            updateLayout()
        }
    }
    
    // MARK: UI Components
    private let stackView = UIStackView().then {
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
        setupTheme()
        setupHierachy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
        clipsToBounds = true
        layer.borderColor = colorTheme.borderColor(state: .enabled).cgColor
        layer.borderWidth = figureTheme.borderWidth()
        
        titleLabel.setTypo(figureTheme.typo())
        titleLabel.textColor = colorTheme.foregroundColor(state: .enabled).uiColor
        
        updateCornerRadius()
    }
    
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
    
    // MARK: Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
        updateCornerRadius()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: UIControl handling
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return true }
        
        UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.backgroundColor = colorTheme.backgroundColor(state: .pressed).uiColor
            self.transform = .init(scaleX: 0.9, y: 0.9)
        })
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        UIView.transition(with: self, duration: 0.2, options: [.curveEaseOut], animations: {
           self.backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
            self.transform = .identity
           })
        sendActions(for: .touchUpInside)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        guard let colorTheme = colorTheme
        else { return }
        
        backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
    }
}
