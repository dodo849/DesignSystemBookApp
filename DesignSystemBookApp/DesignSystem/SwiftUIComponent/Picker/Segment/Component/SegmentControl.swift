//
//  SegmentGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

// 세그먼트는 PickerStyle 커스텀이 어려운 관계로 스타일팩토리 없이 완전한 커스텀 뷰로 구성되었습니다.
// 테마 정보는 styeld 메서드를 통해 store(ObservedObject)로 전달되고 반영됩니다.
public struct SegmentControl<Content, Option>: View where Content: View, Option: Identifiable & Equatable {
    // Initial
    private var sources: [Option]
    private var itemBuilder: (Option) -> Content
    
    // Theme
    @ObservedObject var store: PickerThemeStore
    
    // State
    @Binding private var selection: Option
    
    public init(
        _ sources: [Option],
        selection: Binding<Option>,
        @ViewBuilder itemBuilder: @escaping (Option) -> Content
    ) {
        self.sources = sources
        self._selection = selection
        self.itemBuilder = itemBuilder
        
        self._store = ObservedObject(wrappedValue: PickerThemeStore())
    }
    
    public var body: some View {
        let containerPadding = store.figureTheme.containerPadding()
        let itemPadding = store.figureTheme.itemPadding()
        let spacing = store.figureTheme.itemSpacing().horizontal ?? 0
        let shape = store.figureTheme.shape()
        
        HStack(spacing: spacing) {
            ForEach(sources, id: \.id) { value in
                let itemForegroundColor = store.colorTheme.itemForegroundColor(
                    state: selection == value
                    ? .selected
                    : .unselected
                ).color
                
                itemBuilder(value)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, itemPadding.vertical)
                    .typo(.body2b)
                    .foregroundStyle(itemForegroundColor)
                    .clipShape(shape)
                    .background( // For touch hit area
                        Color.white.opacity(0.01)
                            .onTapGesture {
                                selection = value
                            }
                    )
            }
        }
        .background( // indicator
            GeometryReader { geometry in
                Rectangle()
                    .fill(
                        store.colorTheme.itemBackgroundColor(
                            state: .selected
                        ).color
                    )
                    .frame(
                        maxWidth: max(
                            (geometry.size.width
                             - spacing * CGFloat(sources.count - 1))
                            / CGFloat(sources.count),
                            0
                        )
                    )
                    .clipShape(shape)
                    .shadow(
                        color: store.colorTheme.itemShadowColor(state: .selected).color,
                        radius: 8
                    )
                    .offset(x: offsetForIndicator(in: geometry.size.width))
            }
        )
        .frame(maxWidth: .infinity)
        .padding(.vertical, containerPadding.vertical)
        .padding(.horizontal, containerPadding.horizontal)
        .background(store.colorTheme.containerBackgroundColor().color)
        .clipShape(store.figureTheme.shape())
        .animation(.spring(response: 0.25), value: selection)
        
    }
    
    private func offsetForIndicator(in totalWidth: CGFloat) -> CGFloat {
        let spacing = store.figureTheme.itemSpacing().horizontal ?? 0
        let index = contentIndex(for: selection)
        let itemWidth = (totalWidth - spacing * CGFloat(sources.count - 1)) / CGFloat(sources.count)
        return (itemWidth + spacing) * (CGFloat(index))
    }
    
    private func contentIndex(for option: Option) -> Int {
        return sources.firstIndex(where: { $0 == selection }) ?? 0
    }
}
