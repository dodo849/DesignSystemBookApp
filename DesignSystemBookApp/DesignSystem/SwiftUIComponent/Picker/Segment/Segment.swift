//
//  SegmentGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

public struct Segment<Content, Value>: View where Content: View, Value: Identifiable & Equatable {
    // initial
    private var sources: [Value]
//    @StateObject var store = SegmentStore<Option>()
    private var content: (Value) -> Content
    
    // theme
    @State var colorTheme: PickerColorTheme = BasicSegmentColorTheme(color: .secondary) {
        didSet {
            print("set colorTheme")
            rederingTrigger.toggle()
        }
    }
    @State var figureTheme: PickerFigureTheme = BasicSegmentFigureTheme(shape: .round) {
        didSet {
            rederingTrigger.toggle()
        }
    }
    
    // state
    @State private var selectedValue: Value
    @State private var rederingTrigger: Bool = false
    
    // constant
    private let itemSpacing: CGFloat = 8
    
    init(
        _ sources: [Value],
        selection: Binding<Value>,
        color: SegmentColor = .primary,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.sources = sources 
        self.selectedValue = sources[0]
        self.colorTheme = BasicSegmentColorTheme(color: color)
        self.content = content
    }
    
    public var body: some View {
        let padding = figureTheme.containerPadding()
        GeometryReader { geometry in
            HStack(spacing: itemSpacing) {
                if rederingTrigger {
                    Text("hihi")
                }
                ForEach(sources, id: \.id) { value in
                    content(value)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .typo(.body1b)
                        .foregroundStyle(
                            colorTheme.itemForegroundColor(
                                state: selectedValue == value
                                ? .selected
                                : .unselected
                            ).color
                        )
                        .clipShape(figureTheme.shape())
                        .onTapGesture {
                            selectedValue = value
                        }
                }
            }
            .background(
                Rectangle()
                    .fill(
                        colorTheme.itemBackgroundColor(
                            state: .selected
                        ).color
                    )
                    .frame(
                        maxWidth: max(
                            (geometry.size.width
                             - itemSpacing * CGFloat(sources.count - 1))
                            / CGFloat(sources.count)
                            , 0
                        ),
                        maxHeight: .infinity
                    )
                    .clipShape(figureTheme.shape())
                    .offset(x: offsetForIndicator(in: geometry.size.width))
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, padding.vertical)
            .padding(.horizontal, itemSpacing)
            .background(colorTheme.containerBackgroundColor().color)
            .clipShape(figureTheme.shape())
            .animation(.spring(response: 0.25), value: selectedValue)
        }
    }
    
    private func offsetForIndicator(in totalWidth: CGFloat) -> CGFloat {
        let index = contentIndex(for: selectedValue)
        let itemWidth = (totalWidth - itemSpacing * CGFloat(sources.count + 1)) / CGFloat(sources.count)
        let maxLeftOffset = -CGFloat(sources.count) / 2 + 0.5
        return (itemWidth + itemSpacing) * (maxLeftOffset + CGFloat(index))
    }
    
    private func contentIndex(for option: Value) -> Int {
        return sources.firstIndex(where: { $0 == selectedValue }) ?? 0
    }
    
    func styled(
        color: SegmentColor = .primary,
        shape: SegmentShape = .round
    ) -> some View {
        let newSegment = 
        Segment(
            sources,
            selection: $selectedValue,
            color: color,
            content: content
        )
        return newSegment
    }
}
