//
//  BaseDialog.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseDialog {
    func styled(
        variant: BasicDialogVariant = .shadow,
        shape: BasicDialogShape = .round
    ) {
        let colorTheme = BasicDialogColorTheme(variant: variant)
        let figureTheme = BasicDialogFigureTheme(shape: shape)
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

/// Extension for set content
public extension BaseDialog {
    func addContent(_ content: UIView) {
        self.contentStackView.addArrangedSubview(content)
    }
    
    func open() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        guard let window = windowScene.windows.first
        else { return }
        
        // Add overlayView to UIWindow
        window.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalTo(window)
        }
        
        let duration = 0.3
        self.isHidden = false
        self.overlayView.alpha = 0
        self.backgroundView.alpha = 0
        
        UIView.animate(withDuration: duration) {
            self.overlayView.alpha = 1
            self.backgroundView.alpha = 1
        }
    }
    
    func close() {
        let duration = 0.3
        UIView.animate(withDuration: duration) {
            self.overlayView.alpha = 0
            self.backgroundView.alpha = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.isHidden = true
            }
        }
    }
}

public class BaseDialog: UIView {
    // MARK: Theme
    private var colorTheme: BasicDialogColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicDialogFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: UIConstant
    private let backgroundPadding: CGFloat = 16
    private let pagePadding: CGFloat = 24
    
    // MARK: UI Component
    private let overlayView = UIView()
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .basicBackground
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.setTypo(.body0b)
    }
    
    private let subTitleLabel = UILabel().then {
        $0.setTypo(.body1)
        $0.textColor = .gray06
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        updateCornerRadius()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateCornerRadius()
        updateTheme()
        updateLayout()
    }
    
    public convenience init(
        title: String = "",
        subTitle: String = ""
    ) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        self.isHidden = true
        self.layer.zPosition = 1000
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierachy() { 
        addSubview(overlayView)
        addSubview(backgroundView)
        backgroundView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subTitleLabel)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        
        let rounded = figureTheme.rounded().max
        
        backgroundView.layer.cornerRadius = rounded
    }
    
    private func updateTheme() { 
        guard let colorTheme = colorTheme else { return }
        
        // overaly
        let overlayColor = colorTheme.overlayColor().uiColor
        overlayView.backgroundColor = overlayColor
        
        // shadow
        let shadowColor = colorTheme.shadowColor().cgColor
        backgroundView.layer.shadowColor = shadowColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowRadius = 12
        
    }
    
    private func updateLayout() { 
        overlayView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(pagePadding)
        }
        
        contentStackView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(backgroundPadding)
            $0.bottom.equalTo(backgroundView.snp.bottom).inset(backgroundPadding)
        }
    }
}
