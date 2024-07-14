//
//  BaseCard.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseCard {
    func styled(
        variant: BasicCardVariant = .outline,
        color: BasicCardColor = .gray,
        shape: BasicCardShape = .round,
        padding: BasicCardPadding = .padding
    ) {
        let colorTheme = BasicCardColorTheme(
            variant: variant,
            color: color
        )
        let figureTheme = BasicCardFigureTheme(
            shape: shape, 
            padding: padding
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public class BaseCard: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Theme
    private var colorTheme: BasicCardColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: BasicCardFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: UIConstant
    private let stackViewSpacing: CGFloat = 16
    
    // MARK: UI Component
    private lazy var backgroundView = UIView()
    
    private lazy var headerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    private lazy var footerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    // MARK: Builder
    private var headerComponents: [UIView] = []
    
    private var contentsComponents: [UIView] = []
    
    private var footerComponents: [UIView] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
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
        headerBuilder: ViewBuilder = { [] },
        contentsBuilder: ViewBuilder = { [] },
        footerBuilder: ViewBuilder = { [] }
    ) {
        super.init(frame: .zero)
        
        headerComponents.append(contentsOf: headerBuilder())
        contentsComponents.append(contentsOf: contentsBuilder())
        footerComponents.append(contentsOf: footerBuilder())
        
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierachy() {
        self.addSubview(backgroundView)
        
        backgroundView.addSubview(headerStackView)
        backgroundView.addSubview(contentStackView)
        backgroundView.addSubview(footerStackView)
        
        headerComponents.forEach {
            headerStackView.addArrangedSubview($0)
        }
        
        contentsComponents.forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        footerComponents.forEach {
            footerStackView.addArrangedSubview($0)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        
        let rounded = figureTheme.rounded()
        
        self.backgroundView.layer.cornerRadius = rounded.max
        self.backgroundView.layer.masksToBounds = true
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        guard let figureTheme = figureTheme else { return }
        
        let backgroundColor = colorTheme.backgroundColor().uiColor
        let borderColor = colorTheme.borderColor().cgColor
        
        // background view
        backgroundView.backgroundColor = backgroundColor
        backgroundView.layer.borderColor = borderColor
        backgroundView.layer.borderWidth = 1
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme else { return }
        
        let padding = figureTheme.padding()
        
        if self.superview != nil {
            self.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        backgroundView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
        
        contentStackView.snp.remakeConstraints {
            let stackViewSpacing = calculateStackViewSpacing(
                topStackView: headerStackView,
                bottomStackView: contentStackView
            )
            
            $0.top.equalTo(headerStackView.snp.bottom).offset(stackViewSpacing)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
        
        footerStackView.snp.remakeConstraints {
            let stackViewSpacing = calculateStackViewSpacing(
                topStackView: contentStackView,
                bottomStackView: footerStackView
            )
            
            $0.top.equalTo(contentStackView.snp.bottom).offset(stackViewSpacing)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
            $0.bottom.equalToSuperview().inset(padding.vertical ?? 0)
        }
    }
    
    private func calculateStackViewSpacing(
        topStackView: UIStackView,
        bottomStackView: UIStackView
    ) -> CGFloat {
        let previousSubviewCount = topStackView.arrangedSubviews.count
        let currentViewSubviewCount = bottomStackView.arrangedSubviews.count
        return (previousSubviewCount > 0 && currentViewSubviewCount > 0)
        ? self.stackViewSpacing
        : 0
    }
}
