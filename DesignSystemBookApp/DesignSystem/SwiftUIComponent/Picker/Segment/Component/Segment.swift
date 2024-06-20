//
//  SegmentGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI
import Combine

class SegmentThemeStore: ObservableObject {
    @Published var colorTheme: PickerColorTheme
    @Published var figureTheme: PickerFigureTheme
    
    init() {
        self.colorTheme = BasicSegmentColorTheme(
            variant: .flat,
            color: .primary
        )
        self.figureTheme = BasicSegmentFigureTheme(shape: .round)
    }
}

// 세그먼트는 PickerStyle 커스텀이 어려운 관계로 스타일팩토리 없이 완전한 커스텀 뷰로 구성되었습니다.
// 테마 정보는 styeld 메서드를 통해 store(ObservedObject)로 전달되고 반영됩니다.
public struct Segment<Content, Value>: View where Content: View, Value: Identifiable & Equatable {
    // Initial
    private var sources: [Value]
    private var content: (Value) -> Content
    
    // Theme
    @ObservedObject var store: SegmentThemeStore
    
    // State
    @State private var selectedValue: Value
    
    // Constant
    private let itemSpacing: CGFloat = 8
    
    // Cancelable
    private var cancelable = Set<AnyCancellable>()
    
    init(
        _ sources: [Value],
        selection: Binding<Value>,
        color: BasicSegmentColor = .primary,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.sources = sources
        self.selectedValue = sources[0]
        self.content = content
        
        self._store = ObservedObject(wrappedValue: SegmentThemeStore())
    }
    
    public var body: some View {
        let padding = store.figureTheme.containerPadding()
        HStack(spacing: itemSpacing) {
            ForEach(sources, id: \.id) { value in
                content(value)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .typo(.body1b)
                    .foregroundStyle(
                        store.colorTheme.itemForegroundColor(
                            state: selectedValue == value
                            ? .selected
                            : .unselected
                        ).color
                    )
                    .clipShape(store.figureTheme.shape())
                    .background( // For touch hit area
                        Color.white.opacity(0.01)
                            .onTapGesture {
                                selectedValue = value
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
                             - itemSpacing * CGFloat(sources.count - 1))
                            / CGFloat(sources.count),
                            0
                        )
                    )
                    .clipShape(store.figureTheme.shape())
                    .shadow(
                        color: store.colorTheme.itemShadowColor(state: .selected).color,
                        radius: 4
                    )
                    .offset(x: offsetForIndicator(in: geometry.size.width))
            }
        )
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.vertical, padding.vertical)
        .padding(.horizontal, itemSpacing)
        .background(store.colorTheme.containerBackgroundColor().color)
        .clipShape(store.figureTheme.shape())
        .animation(.spring(response: 0.25), value: selectedValue)
        
    }
    
    private func offsetForIndicator(in totalWidth: CGFloat) -> CGFloat {
        let index = contentIndex(for: selectedValue)
        let itemWidth = (totalWidth - itemSpacing * CGFloat(sources.count - 1)) / CGFloat(sources.count)
        //        let maxLeftOffset = -CGFloat(sources.count) / 2 + 0.5
        //        return (itemWidth + itemSpacing) * (maxLeftOffset + CGFloat(index))
        return (itemWidth + itemSpacing) * (CGFloat(index))
    }
    
    private func contentIndex(for option: Value) -> Int {
        return sources.firstIndex(where: { $0 == selectedValue }) ?? 0
    }
}
