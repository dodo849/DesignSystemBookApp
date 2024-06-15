//
//  TextFieldBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct TextFieldBookView: View {
    
    @State var text: String = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        TextField("메렁", text: $text)
            .textFieldStyle(CustomTextFieldStyle())
        
        Label("Settings", systemImage: "gear")
            .padding()
            .font(.title)
    }
}

#Preview {
    TextFieldBookView()
}
