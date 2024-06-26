//
//  SegmentControlBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import UIKit

import Then
import SnapKit

final class SegmentControlBookView: BaseView {
    struct SegmentOption: Identifiable, Equatable {
        let id: Int
        
        static func factory(_ options: [Int]) -> [SegmentOption] {
            return options.map { SegmentOption(id: $0) }
        }
    }
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    let segmentControl = BaseSegmentControl(
        source: SegmentOption.factory(Array(0...3)),
        itemBuilder: { option in
            UILabel().then {
                $0.text = "Segment \(option.id)"
                $0.textAlignment = .center
            }
        }
    )
    
    override func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(segmentControl)
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
    }
}
