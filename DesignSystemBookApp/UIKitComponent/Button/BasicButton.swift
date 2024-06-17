//
//  BasicButton.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit

import Then

class BasicButton: UIControl {

    private let titleLabel = UILabel().then {
        $0.text = "Button"
        $0.setTypo(.body1)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        // 기본 스타일 설정
        backgroundColor = .systemBlue
        layer.cornerRadius = 10

        // titleLabel 설정
        titleLabel.textColor = .white
        titleLabel.text = "Button"
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        // 레이아웃 설정
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 필요 시 추가적인 그리기 코드 작성
    }

    // UIControl 이벤트 핸들링
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // 터치 시작
        backgroundColor = .darkGray
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // 터치 종료
        backgroundColor = .systemBlue
        sendActions(for: .touchUpInside)
    }

    override func cancelTracking(with event: UIEvent?) {
        // 터치 취소
        backgroundColor = .systemBlue
    }
}

