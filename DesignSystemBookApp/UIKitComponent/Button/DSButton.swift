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
        
//        self.animationWithColor(
//            fromColor: colorTheme.backgroundColor(state: .enabled).cgColor,
//            toColor: colorTheme.backgroundColor(state: .pressed).cgColor
//        ) { [weak self] in
//            guard let self = self else { return }
//            
//            if let colorTheme = self.colorTheme {
//                self.transform = .init(scaleX: 0.9, y: 0.9)
//            }
//        }
        
        UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            self.backgroundColor = colorTheme.backgroundColor(state: .pressed).uiColor
            self.transform = .init(scaleX: 0.9, y: 0.9)
        }) { (finish) in
        }
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return true }
        print("continue")
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        self.animationWithColor(
            fromColor: colorTheme.backgroundColor(state: .pressed).cgColor,
            toColor: colorTheme.backgroundColor(state: .enabled).cgColor
        ) { [weak self] in
            guard let self = self else { return }
            
            if let colorTheme = self.colorTheme {
                self.transform = .identity
            }
        }
        UIView.transition(with: self, duration: 0.4, options: .curveEaseOut, animations: {
               self.backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
           }) { (finish) in
           }
        
        
        sendActions(for: .touchUpInside)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        guard let colorTheme = colorTheme
        else { return }
        
        backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
    }
    
    // MARK: Animation
    private func animationWithColor(
        fromColor: CGColor,
        toColor: CGColor,
        _ completion: @escaping () -> Void
    ) {
//        let caLayer = CALayer()
//        caLayer.backgroundColor = self.backgroundColor?.cgColor
//        caLayer.frame = self.bounds
//        self.layer.addSublayer(caLayer)
//
//        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
//        colorAnimation.duration = 0.35
//        colorAnimation.fromValue = fromColor
//        colorAnimation.toValue = toColor
//        colorAnimation.isRemovedOnCompletion = false
//        colorAnimation.fillMode = .forwards
//        colorAnimation.repeatCount = 1
//        colorAnimation.delegate = LayerRemover(for: caLayer)
//        caLayer.add(colorAnimation, forKey: "backgroundColorChange")
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: [.layoutSubviews]
        ) {
            completion()
        }
    }
}

class LayerRemover: NSObject, CAAnimationDelegate {
    private weak var layer: CALayer?

    init(for layer: CALayer) {
        self.layer = layer
        super.init()
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("stop")
        layer?.removeFromSuperlayer()
    }
}
