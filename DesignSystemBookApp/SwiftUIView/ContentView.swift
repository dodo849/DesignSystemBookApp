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
                    
                    Text("CheckButton")
                        .font(.system(size: 20, weight: .bold))
                    NavigationLink(destination: CheckButtonBookView()) {
                        Text("CheckButton example")
                    }
                    
                    Spacer().frame(height: 20)
                    
                    Text("RadioButton")
                        .font(.system(size: 20, weight: .bold))
                    NavigationLink(destination: RadioButtonBookView()) {
                        Text("RadioButton example")
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
