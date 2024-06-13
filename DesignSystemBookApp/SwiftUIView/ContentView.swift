//
//  ContentView.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Button")
                    .font(.system(size: 20, weight: .bold))
                NavigationLink(destination: ButtonBookView()) {
                    Text("Button example")
                }
            }
            .padding(.horizontal)
            .frameMax([.width], alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
