//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then

extension DSButton {
    func styled(
        variant: BasicButtonVariant = .fill,
        color: BasicButtonColor = .primary,
        size: BasicButtonSize = .large,
        shape: BasicButtonShape = .round
    ) -> Self {
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
        return self
    }
}

class DSButton: UIControl {
    // MARK: Theme
    private var colorTheme: ButtonColorTheme? {
        didSet {
            setupTheme()
        }
    }
    private var figureTheme: ButtonFigureTheme? {
        didSet {
            setupTheme()
        }
    }
    
    // MARK: UI Components
    private let titleLabel = UILabel().then {
        $0.text = "Button"
        $0.setTypo(.body1)
        $0.textAlignment = .center
    }
    
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
        
        // Setup default style
        backgroundColor = colorTheme.backgroundColor(state: .enabled).uiColor
        layer.cornerRadius = figureTheme.rounded().max
        
        titleLabel.textColor = colorTheme.foregroundColor(state: .enabled).uiColor
    }
    
    private func setupHierachy() {
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        guard let figureTheme = figureTheme
        else { return }
        
        let padding = figureTheme.padding()
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupBind() {
        
    }
    
    // MARK: Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("언제 호출되는거지")
        // 필요 시 추가적인 그리기 코드 작성
    }
    
    // MARK: UIControl handling
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return true }
        
        self.animationWithColor { [weak self] in
            guard let self = self else { return }
            
            if let colorTheme = self.colorTheme {
                self.transform = .init(scaleX: 0.9, y: 0.9)
                self.backgroundColor = colorTheme
                    .backgroundColor(state: .pressed).uiColor
            }
            self.layoutIfNeeded()
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        self.animationWithColor { [weak self] in
            guard let self = self else { return }
            
            if let colorTheme = self.colorTheme {
                self.transform = .identity
                self.backgroundColor = colorTheme
                    .backgroundColor(state: .enabled).uiColor
            }
            self.layoutIfNeeded()
        }
        sendActions(for: .touchUpInside)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        // 터치 취소
        backgroundColor = .systemBlue
    }
    
    // MARK: Animation
    private func animationWithColor(
        _ completion: @escaping () -> Void
    ) {
//        let caLayer = CALayer()
//        caLayer.backgroundColor = self.backgroundColor?.cgColor
//        caLayer.frame = self.bounds
//        self.layer.addSublayer(caLayer)
//
//        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
//        colorAnimation.duration = 0.35
//        colorAnimation.toValue = toColor
//        colorAnimation.isRemovedOnCompletion = false
//        colorAnimation.fillMode = .forwards
//        colorAnimation.repeatCount = 1
//        caLayer.add(colorAnimation, forKey: "backgroundColorChange")
//
//        // 업데이트된 색상을 유지하도록 설정
//        caLayer.backgroundColor = toColor
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.4,
            options: []
        ) {
            completion()
        } completion: { _ in
            print("Animation Completed")
        }
    }
}
