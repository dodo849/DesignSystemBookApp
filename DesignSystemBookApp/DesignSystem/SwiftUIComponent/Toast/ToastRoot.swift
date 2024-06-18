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
    @Published fileprivate var colorTheme: ToastColorTheme
    @Published fileprivate var figureTheme: ToastFigureTheme
    
    public static let shared = ToastManager()
    
    private init() {
        self.colorTheme = BasicToastColorTheme(variant: .info)
        self.figureTheme = BasicToastFigureTheme(
            variant: .info,
            shape: .round
        )
    }
    
    public func showToast(
        message: String,
        variant: ToastVariant = .info,
        shape: ToastShape = .round,
        openTime: Double = 4
    ) {
        self.colorTheme = BasicToastColorTheme(variant: variant)
        self.figureTheme = BasicToastFigureTheme(
            variant: variant,
            shape: shape
        )
        
        toastMessage = message
        withAnimation(.bouncy(duration: 0.35)) {
            isOpen = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + openTime) { [weak self] in
            withAnimation(.bouncy(duration: 0.35)) {
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
                    Toast(
                        message: toastManager.toastMessage,
                        colorTheme: toastManager.colorTheme,
                        figureTheme: toastManager.figureTheme
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.bottom, 30)
                }
            }
        }
    }
}
