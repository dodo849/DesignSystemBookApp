//
//  TabViewBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/19/24.
//

import SwiftUI
struct SegmentBook: View {
    fileprivate struct SegmentOption: Identifiable, Equatable {
        let id: Int
        
        static func factory(_ options: [Int]) -> [SegmentOption] {
            return options.map { SegmentOption(id: $0) }
        }
    }
    @State private var selectedVariant =  BasicSegmentVariant.allCases.first!
    private var variants = BasicSegmentVariant.allCases
    @State private var selectedColor =  BasicSegmentColor.allCases.first!
    private var colors = BasicSegmentColor.allCases
    @State private var selectedShape =  BasicSegmentShape.allCases.first!
    private var shapes = BasicSegmentShape.allCases
    
    @State private var selection = SegmentOption(id: 0)
    @State private var optionCount = 3
    
    @State var state: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Stepper(value: $optionCount, in: 1...10) {
                    Text("Option count \(optionCount)")
                        .typo(.body1b)
                }
                .padding()
                .background(.gray01)
                .cornerRadius(12)
                
                Text("Variant")
                    .typo(.body1b)
                Picker("Choose a variant", selection: $selectedVariant) {
                    ForEach(variants, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("Color")
                    .typo(.body1b)
                Picker("Choose a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("Shape")
                    .typo(.body1b)
                Picker("Choose a shape", selection: $selectedShape) {
                    ForEach(shapes, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                    .padding(.vertical)
                
                SegmentControl(
                    SegmentOption.factory(Array(0..<optionCount)),
                    selection: $selection
                ) { option in
                    Text("\(option.id)")
                }.styled(
                    variant: selectedVariant,
                    color: selectedColor,
                    shape: selectedShape
                )
                
                // MARK: With others
                Divider()
                    .padding(.vertical)
                
                Text("With others")
                    .font(.system(size: 16, weight: .semibold))
                
                SegmentControl(
                    SegmentOption.factory(Array(0..<optionCount)),
                    selection: $selection
                ) { option in
                    HStack {
                        Text("\(option.id)")
                        if option.id == 1 {
                            Text("N")
                                .typo(.detail)
                                .padding(6)
                                .foregroundStyle(.white)
                                .background(.destructive)
                                .clipShape(Circle())
                        }
                    }
                }.styled(
                    variant: selectedVariant,
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
