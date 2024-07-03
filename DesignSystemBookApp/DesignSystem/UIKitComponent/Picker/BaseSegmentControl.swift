//
//  BaseSegmentControl..swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

/// Extension for set theme
public extension BaseSegmentControl {
    func styled(
        variant: BasicSegmentVariant = .flat,
        color: BasicSegmentColor = .primary,
        shape: BasicSegmentShape = .round
    ) {
        self.colorTheme = BasicSegmentColorTheme(
            variant: variant,
            color: color
        )
        self.figureTheme = BasicSegmentFigureTheme(shape: shape)
    }
}

public class BaseSegmentControl<Option>: UIView where Option: Equatable & Identifiable {
    // MARK: Event
    var onChange: PublishSubject<Option> = PublishSubject()
    
    // MARK: Theme
    private var colorTheme: PickerColorTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: PickerFigureTheme? {
        didSet {
            updateCornerRadius()
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: Source
    private var source: [Option] = []
    
    private var itemBuilder: (Option) -> UIView = { _ in UIView() }
    
    // MARK: UI Component
    private let containerView = UIView()
    
    private let indicator = UIView()
    
    private let itemStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    // MARK: Offset
    private var selectedIndex: Int = 0
    private var indicatorLeadingOffset: CGFloat = 0
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupBind()
        updateCornerRadius()
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
        source: [Option],
        itemBuilder: @escaping (Option) -> UIView
    ) {
        self.init(frame: .zero)
        self.source = source
        self.itemBuilder = itemBuilder
        
        setupHierachy()
        setupBind()
        updateCornerRadius()
        updateTheme()
        updateLayout()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierachy() {
        addSubview(containerView)
        containerView.addSubview(indicator)
        containerView.addSubview(itemStack)
        
        source.forEach { option in
            let itemView = itemBuilder(option)
            let itemContainerView = UIView()
            itemContainerView.addSubview(itemView)
            itemStack.addArrangedSubview(itemContainerView)
        }
    }
    
    private func setupBind() {
        itemStack.subviews.enumerated().forEach { index, itemView in
            let tapGestureRecognizer = UITapGestureRecognizer()
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(tapGestureRecognizer)
            
            tapGestureRecognizer.rx.event
                .withUnretained(self)
                .map { owner, _ in
                    owner.selectedIndex = index
                    
                    let containerPadding = owner.figureTheme?.containerPadding()
                    
                    owner.indicatorLeadingOffset = (itemView.bounds.width
                        + owner.itemStack.spacing)
                        * CGFloat(index)
                        + (containerPadding?.horizontal ?? 0)
                    
                    owner.updateLayout()
                    owner.updateTheme()
                    
                    return owner.source[index]
                }
                .bind(to: onChange)
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        let containerRounded = figureTheme.containerRounded().max
        let itemRounded = figureTheme.itemRounded().max
        
        let containerViewrounded = containerRounded == .infinity
        ? containerView.bounds.height / 2 : containerRounded
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = containerViewrounded
        
        let itemViewRounded = itemRounded == .infinity
        ? indicator.bounds.height / 2 : itemRounded
        
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = itemViewRounded
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        guard let figureTheme = figureTheme else { return }
        
        let containerBackgroundColor = colorTheme
            .containerBackgroundColor().uiColor
        let indicatorBackgroundColor = colorTheme
            .itemBackgroundColor(state: .selected).uiColor        
        let indicatorShadowColor = colorTheme
            .itemShadowColor(state: .selected).cgColor
        let itemSpacing = figureTheme.itemSpacing()
        
        // Container
        containerView.backgroundColor = containerBackgroundColor
        
        // Indicator
        indicator.backgroundColor = indicatorBackgroundColor
        indicator.layer.shadowColor = indicatorShadowColor
        indicator.layer.shadowOffset = CGSize(width: 0, height: 0)
        indicator.layer.shadowOpacity = 1
        indicator.layer.shadowRadius = 8
        indicator.layer.masksToBounds = false
        
        // Item Stack
        itemStack.spacing = itemSpacing.horizontal ?? 0
        
        // Item foreground color
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            itemStack.subviews.enumerated().forEach { index, itemContainerView in
                let isSelected = index == self.selectedIndex
                
                itemContainerView.subviews.forEach {
                    let foregroundColor = colorTheme.itemForegroundColor(
                        state: isSelected ? .selected : .unselected
                    ).uiColor
                    
                    if let label = $0 as? UILabel {
                        label.setTypo(.body2b)
                        label.textColor = foregroundColor
                        label.textAlignment = .center
                    }
                    $0.tintColor = foregroundColor
                }
            }
        }
    }

    private func updateLayout() {
        guard let figureTheme = figureTheme else { return }
        let containerPadding = figureTheme.containerPadding()
        let itemPadding = figureTheme.itemPadding()
        
        if indicatorLeadingOffset <= 0 {
            indicatorLeadingOffset = containerPadding.horizontal ?? 0
        }
        
        containerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicator.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(containerPadding.vertical ?? 0)
            $0.left.equalToSuperview().inset(containerPadding.horizontal ?? 0)
            if let firstItem = itemStack.subviews.first {
                $0.width.equalTo(firstItem.bounds.width)
            }
        }
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            self.indicator.frame.origin.x = self.indicatorLeadingOffset
        }
        
        itemStack.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(containerPadding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(containerPadding.horizontal ?? 0)
        }
        
        itemStack.subviews.forEach { itemContainerView in
            itemContainerView.subviews.first?.snp.remakeConstraints {
                $0.top.bottom.equalToSuperview().inset(itemPadding.vertical ?? 0)
                $0.left.right.equalToSuperview().inset(itemPadding.horizontal ?? 0)
            }
        }
    }
}
