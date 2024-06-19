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
    
    @State private var selection: TempOption = TempOption(id: 0)

    fileprivate var options = [
        TempOption(id: 0),
        TempOption(id: 1),
        TempOption(id: 2)
    ]
    
    var body: some View {
        VStack {
            SegmentGroup(selection: $selection) {
                ForEach (options, id: \.id) { option in
                    SegmentOption(value: option) {
                        Text("\(option.id)")
                    }
                }
            }
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
