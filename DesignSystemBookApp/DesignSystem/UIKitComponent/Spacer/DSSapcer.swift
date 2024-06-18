//
//  DSSapcer.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import UIKit

/// This view is used as a flexible space in a UIStackView to occupy space without having any content.
class DSSapcer: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    /// Sets up the view by configuring its content hugging and compression resistance priorities.
    /// This ensures the view expands to fill available space within a UIStackView.
    private func setupView() {
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
