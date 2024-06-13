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
            ScrollView {
                Spacer().frame(height: 100)
                
                VStack(alignment: .leading) {
                    Text("Button")
                        .font(.system(size: 20, weight: .bold))
                    NavigationLink(destination: ButtonBookView()) {
                        Text("Button example")
                    }
                    
                    Spacer().frame(height: 20)
                    
                    Text("Checkbox")
                        .font(.system(size: 20, weight: .bold))
                    NavigationLink(destination: CheckboxBookView()) {
                        Text("Checkbox example")
                    }
                }
                .padding(.horizontal)
            }
            .frameMax([.width], alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
