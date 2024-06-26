//
//  ChipControlBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/25/24.
//

import SwiftUI

struct ChipControlBook: View {
    fileprivate struct ChipOption: Identifiable, Equatable {
        let id = UUID()
        let text: String
        
        static func factory(_ options: [String]) -> [ChipOption] {
            return options.map { ChipOption(text: $0) }
        }
    }
    
    @State private var selectedVariant =  BasicChipVariant.allCases.first!
    private var variants = BasicChipVariant.allCases
    @State private var selectedColor =  BasicChipColor.allCases.first!
    private var colors = BasicChipColor.allCases
    @State private var selectedShape =  BasicChipShape.allCases.first!
    private var shapes = BasicChipShape.allCases
    @State private var selectedOverflow =  ChipControlOverflow.allCases.first!
    private var overflows = ChipControlOverflow.allCases
    @State private var selectedMultiple =  ChipControlMultipleSelection.allCases.first!
    private var multiples = ChipControlMultipleSelection.allCases
    
    @State private var selections: [ChipOption] = []
    
    @State private var options = ChipOption.factory([
        "Swift", "Long description", "Short", "Very long description chip",
        "Chip"
    ])
    
    @State var state: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
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
                
                Text("Overflow")
                    .typo(.body1b)
                Picker("Choose a overflow", selection: $selectedOverflow) {
                    ForEach(overflows, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("Multiple selection")
                    .typo(.body1b)
                Picker("Choose a multiple", selection: $selectedMultiple) {
                    ForEach(multiples, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Divider()
                    .padding(.vertical)
                
                ChipControl(
                    options,
                    selections: $selections,
                    overflow: selectedOverflow,
                    multipleSelection: selectedMultiple
                ) { option in
                    Text("\(option.text)")
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
