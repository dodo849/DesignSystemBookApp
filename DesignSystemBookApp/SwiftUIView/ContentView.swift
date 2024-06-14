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
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Button")
                        .font(.system(size: 24, weight: .bold))
                    Text("Basic Button")
                        .font(.system(size: 18, weight: .semibold))
                    Text("Color theme **Basic** | Figure theme **Basic**")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    NavigationLink(destination: BasicButtonBookView()) {
                        Text("Basic Button example")
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Text("Gray Button")
                        .font(.system(size: 18, weight: .semibold))
                    Text("Color theme **Gray** | Figure theme **Basic**")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    NavigationLink(destination: GrayButtonBookView()) {
                        Text("Gray Button example")
                    }
                    
                    Spacer().frame(height: 20)
                    
                    Text("ToggleButton")
                        .font(.system(size: 24, weight: .bold))
                    Text("CheckButton")
                        .font(.system(size: 18, weight: .bold))
                    Text("Color theme **Basic** | Figure theme **Basic**")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    NavigationLink(destination: CheckButtonBookView()) {
                        Text("CheckButton example")
                    }
                    
                    Spacer().frame(height: 20)
                    
                    Text("RadioButton")
                        .font(.system(size: 18, weight: .bold))
                    Text("Color theme **Basic** | Figure theme **Basic**")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
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
