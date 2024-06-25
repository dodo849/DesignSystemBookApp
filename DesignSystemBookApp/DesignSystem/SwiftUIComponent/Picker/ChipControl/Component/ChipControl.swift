//
//  ChipControl.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

public enum ChipControlOverflow: String, CaseIterable {
    case wrap, scroll
}

public enum ChipControlMultipleSelection: String, CaseIterable {
    case allow, deny
}

public struct ChipControl<Content, Value>: View where Content: View, Value: Identifiable & Equatable {
    // Initial
    private var sources: [Value]
    private var content: (Value) -> Content
    private var overflow: ChipControlOverflow
    private var multipleSelection: ChipControlMultipleSelection
    
    // Theme
    @ObservedObject var store: PickerThemeStore
    
    // State
    @Binding private var selections: [Value]
    
    public init(
        _ sources: [Value],
        selections: Binding<[Value]>,
        overflow: ChipControlOverflow = .wrap,
        multipleSelection: ChipControlMultipleSelection = .allow,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.sources = sources
        self._selections = selections
        self.content = content
        self.overflow = overflow
        self.multipleSelection = multipleSelection
        
        self._store = ObservedObject(wrappedValue: PickerThemeStore())
    }
    
    public var body: some View {
        let spacing = store.figureTheme.itemSpacing().horizontal ?? 0
        
        Group {
            if overflow == .wrap {
                OverflowGrid(horizontalSpacing: spacing) {
                    chipItems
                }
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: spacing) {
                        chipItems
                    }
                    .padding(2) // Prevent overlap between the border and the container view
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.spring(response: 0.25), value: selections)
    }
    
    private var chipItems: some View {
        ForEach(sources, id: \.id) { value in
            let selectState: PickerState = selections.contains(value)
            ? .selected : .unselected
            let padding = store.figureTheme.itemPadding()
            
            content(value)
                .padding(.vertical, padding.vertical)
                .padding(.horizontal, padding.horizontal)
                .typo(selectState == .selected ? .body2b : .body2)
                .foregroundStyle(
                    store.colorTheme.itemForegroundColor(
                        state: selectState
                    ).color
                )
                .background(
                    store.colorTheme.itemBackgroundColor(
                        state: selectState
                    ).color
                )
                .clipShape(store.figureTheme.shape())
                .overlay {
                    store.figureTheme.shape()
                        .stroke(
                            store.colorTheme.itemBorderColor(state: selectState).color,
                            lineWidth: 1
                        )
                }
                .onTapGesture {
                    if selections.contains(value) {
                        selections.removeAll { $0 == value }
                    } else {
                        selections.append(value)
                        if multipleSelection == .deny {
                            selections.removeAll { $0 != value }
                        }
                    }
                }
        }
    }
}

/// ref : https://stackoverflow.com/questions/58842453/hstack-with-wrap/58876712#58876712
public struct OverflowGrid: Layout {
    private var horizontalSpacing: CGFloat
    private var vericalSpacing: CGFloat
    public init(horizontalSpacing: CGFloat, vericalSpacing: CGFloat? = nil) {
        self.horizontalSpacing = horizontalSpacing
        self.vericalSpacing = vericalSpacing ?? horizontalSpacing
    }
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let height = subviews.max(
            by: {$0.dimensions(in: proposal).height > $1.dimensions(in: proposal).height}
        )?.dimensions(in: proposal).height ?? 0
        var rows = [CGFloat]()
        subviews.indices.forEach { index in
            let rowIndex = rows.count - 1
            let subViewWidth = subviews[index].dimensions(in: proposal).width
            guard !rows.isEmpty else {
                rows.append(subViewWidth)
                return
            }
            let newWidth = rows[rowIndex] + subViewWidth + horizontalSpacing
            if newWidth < proposal.width ?? 0 {
                rows[rowIndex] += (rows[rowIndex] > 0 ? horizontalSpacing: 0) + subViewWidth
            } else {
                rows.append(subViewWidth)
            }
        }
        let count = CGFloat(rows.count)
        return CGSize(
            width: rows.max() ?? 0,
            height: count * height + (count - 1) * vericalSpacing
        )
        
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let height = subviews.max(
            by: {$0.dimensions(in: proposal).height > $1.dimensions(in: proposal).height}
        )?.dimensions(in: proposal).height ?? 0
        guard !subviews.isEmpty else {return}
        var x = bounds.minX
        var y = height/2 + bounds.minY
        subviews.indices.forEach { index in
            let subView = subviews[index]
            x += subView.dimensions(in: proposal).width/2
            subviews[index].place(at: CGPoint(x: x, y: y), anchor: .center, proposal: ProposedViewSize(width: subView.dimensions(in: proposal).width, height: subView.dimensions(in: proposal).height))
            x += horizontalSpacing + subView.dimensions(in: proposal).width/2
            if x > bounds.width {
                x = bounds.minX
                y += height + vericalSpacing
            }
        }
    }
}
