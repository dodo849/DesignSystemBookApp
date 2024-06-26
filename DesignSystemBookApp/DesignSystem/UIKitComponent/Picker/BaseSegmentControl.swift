//
//  BaseSegmentControl..swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import UIKit

import Then
import SnapKit

class BaseSegmentControl<Option>: UIView where Option: Equatable & Identifiable {
    // MARK: Theme
    private var colorTheme: PickerColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: PickerFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    // MARK: Source
    private var source: [Option] = []
    
    private var itemBuilder: (Option) -> UIView = { _ in UIView() }
    
    // MARK: UI Component
    private let backgroundView = UIView()
    
    private let indicator = UIView()
    
    private let itemStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.backgroundColor = .basicPink
    }
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateSource()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateSource()
    }
    
    convenience init(
        source: [Option],
        itemBuilder: @escaping (Option) -> UIView
    ) {
        self.init(frame: .zero)
        self.source = source
        self.itemBuilder = itemBuilder
        
        setupHierachy()
        setupBind()
        updateTheme()
        updateLayout()
        updateSource()
        
    }
    
    // MARK: Life cycle
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
//        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierachy() {
        addSubview(backgroundView)
        backgroundView.addSubview(indicator)
        backgroundView.addSubview(itemStack)
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateSource() {
        itemStack.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        source.forEach {
            let itemView = itemBuilder($0)
            
            itemStack.addArrangedSubview(itemView)
        }
    }
    
    private func updateTheme() {
    }
    
    private func updateLayout() {
        backgroundView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemStack.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
