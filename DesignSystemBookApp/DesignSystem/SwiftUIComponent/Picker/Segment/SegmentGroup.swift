//
//  SegmentGroup.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

final class SegmentStore<Option: Identifiable & Equatable>: ObservableObject {
    @Published var selectedOption: Option?
    @Published var colorTheme: PickerColorTheme
    @Published var figureTheme: PickerFigureTheme
    
    init(
        selectedOption: Option? = nil,
        colorTheme: PickerColorTheme = BasicSegmentColorTheme(color: .primary),
        figureTheme: PickerFigureTheme = BasicSegmentFigureTheme(shape: .round)
    ) {
        self.selectedOption = selectedOption
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public struct SegmentGroup<Content, Option>: View where Content: View, Option: Identifiable & Equatable {
    private var sources: [Option]
    @StateObject var store = SegmentStore<Option>()
    private var content: (Option) -> Content
    
    private let itemSpacing: CGFloat = 8
    
    init(
        _ sources: [Option],
        selection: Binding<Option>,
        @ViewBuilder content: @escaping (Option) -> Content
    ) {
        self.sources = sources 
        self._store = StateObject(
            wrappedValue: SegmentStore<Option>(
                selectedOption: selection.wrappedValue
            )
        )
        self.content = content
    }
    
    public var body: some View {
        let padding = store.figureTheme.containerPadding()
        GeometryReader { geometry in
            HStack(spacing: itemSpacing) {
                ForEach(sources, id: \.id) { item in
                    content(item)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(.blue.opacity(0.2))
                        .clipShape(store.figureTheme.shape())
                        .onTapGesture {
                            store.selectedOption = item
                        }
                        
                }
            }
            .coordinateSpace(name: "HStack")
            .background(
                Rectangle()
                    .fill(Color.red)
                    .frame(
                        width: (geometry.size.width - itemSpacing * CGFloat(sources.count + 1)) / CGFloat(sources.count),
                        height: .infinity
                    )
                    .clipShape(store.figureTheme.shape())
                    .offset(x: offsetForIndicator(in: geometry.size.width))
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, padding.vertical)
            .padding(.horizontal, itemSpacing)
            .background(Color.gray.opacity(0.1))
            .clipShape(store.figureTheme.shape())
            .animation(.spring(response: 0.35), value: store.selectedOption)
            .environmentObject(store)
        }
    }
    
    private func offsetForIndicator(in totalWidth: CGFloat) -> CGFloat {
        guard let selectedOption = store.selectedOption else { return 0 }
        let index = contentIndex(for: selectedOption)
        let itemWidth = (totalWidth - itemSpacing * CGFloat(sources.count + 1)) / CGFloat(sources.count)
        let maxLeftOffset = -CGFloat(sources.count) / 2 + 0.5
        print((maxLeftOffset + CGFloat(index)))
        return (itemWidth + itemSpacing) * (maxLeftOffset + CGFloat(index))
    }
    
    private func contentIndex(for option: Option) -> Int {
        return sources.firstIndex(where: { $0 == store.selectedOption }) ?? 0
    }
    
}

public extension SegmentGroup {
    func styled(
        color: SegmentColor = .primary,
        shape: SegmentShape = .round
    ) -> some View {
        store.colorTheme = BasicSegmentColorTheme(color: color)
        return self
    }
}
