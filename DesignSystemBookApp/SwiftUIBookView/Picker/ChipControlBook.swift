//
//  ChipControlBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

struct ChipControlBook: View {
    fileprivate struct ChipOption: Identifiable, Equatable {
        let id: Int
        
        static func factory(_ options: [Int]) -> [ChipOption] {
            return options.map { ChipOption(id: $0) }
        }
    }
    
    @State private var selectedVariant =  BasicChipVariant.allCases.first!
    private var variants = BasicChipVariant.allCases
    @State private var selectedColor =  BasicChipColor.allCases.first!
    private var colors = BasicChipColor.allCases
    @State private var selectedShape =  BasicChipShape.allCases.first!
    private var shapes = BasicChipShape.allCases
    
    @State private var selections: [ChipOption] = []
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
                
                ChipControl(
                    ChipOption.factory(Array(0..<optionCount)),
                    selections: $selections
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
                
                ChipControl(
                    ChipOption.factory(Array(0..<optionCount)),
                    selections: $selections
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

#Preview {
    ChipControlBook()
}
