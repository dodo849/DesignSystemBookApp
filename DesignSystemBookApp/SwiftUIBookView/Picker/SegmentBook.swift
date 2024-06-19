//
//  TabViewBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI

struct TempOption: Identifiable, Equatable {
    let id: Int
}

struct SegmentBook: View {
    
    @State private var selectedColor =  SegmentColor.allCases.first!
    private var colors = SegmentColor.allCases
    @State private var selectedShape =  SegmentShape.allCases.first!
    private var shapes = SegmentShape.allCases

    @State private var selection = TempOption(id: 0)
    fileprivate var options = [
        TempOption(id: 0),
        TempOption(id: 1),
        TempOption(id: 2),
        TempOption(id: 3),
        TempOption(id: 4)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Color")
                    .typo(.body1b)
                Picker("Choose a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("color \(selectedColor)")
                
                Text("Shape")
                    .typo(.body1b)
                Picker("Choose a shape", selection: $selectedShape) {
                    ForEach(shapes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Segment(options, selection: $selection) { option in
                    Text("\(option.id)")
                }.styled(
                    color: selectedColor,
                    shape: selectedShape
                )

            }
            .padding(pagePadding)
        }
    }
}

struct FirstView: View {
    var body: some View {
        Text("First View")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Third View")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

#Preview {
    SegmentBook()
}
