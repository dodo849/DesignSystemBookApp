//
//  Toast.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import SwiftUI

struct Toast: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
