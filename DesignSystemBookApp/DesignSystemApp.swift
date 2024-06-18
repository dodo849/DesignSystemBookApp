//
//  DesignSystemApp.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 6/13/24.
//

import SwiftUI

@main
struct DesignSystemApp: App {
    var body: some Scene {
        WindowGroup {
            ToastFactory {
                ContentView()
                    .foregroundStyle(.basicText) // For set default text color
            }
        }
    }
}
