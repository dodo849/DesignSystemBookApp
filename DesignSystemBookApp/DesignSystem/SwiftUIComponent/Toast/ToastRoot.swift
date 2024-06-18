//
//  RootView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import SwiftUI

public class ToastManager: ObservableObject {
    @Published fileprivate var isOpen: Bool = false
    @Published fileprivate var toastMessage: String = ""
    
    public static let shared = ToastManager()
    
    private init() {}
    
    public func showToast(
        message: String,
        openTime: Double = 3
    ) {
        toastMessage = message
        withAnimation {
            isOpen = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + openTime) { [weak self] in
            withAnimation {
                self?.isOpen = false
            }
        }
    }
}

public struct ToastRoot<Content: View>: View {
    @StateObject private var toastManager = ToastManager.shared
    private let content: () -> Content
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            content()

            VStack {
                Spacer()
                if toastManager.isOpen {
                    Toast(message: toastManager.toastMessage)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.1), value: toastManager.isOpen)
                        .padding(.bottom, 30)
                }
            }
        }
    }
}
