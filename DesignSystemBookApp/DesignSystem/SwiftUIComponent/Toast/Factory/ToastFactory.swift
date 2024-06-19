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
    @Published fileprivate var alignment: ToastAlignment = .bottom
    
    public static let shared = ToastManager()
    
    private var currentWorkItem: DispatchWorkItem?
    
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
        alignment: ToastAlignment = .bottom,
        duration: TimeInterval = 4.0
    ) {
        currentWorkItem?.cancel()
        
        self.colorTheme = BasicToastColorTheme(variant: variant)
        self.figureTheme = BasicToastFigureTheme(
            variant: variant,
            shape: shape
        )
        self.alignment = alignment
        
        toastMessage = message
        withAnimation(.bouncy(duration: 0.35)) {
            isOpen = true
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            withAnimation(.bouncy(duration: 0.35)) {
                self?.isOpen = false
            }
        }
        
        currentWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + duration,
            execute: workItem
        )
    }
}

public struct ToastFactory<Content: View>: View {
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
                if toastManager.alignment == .bottom {
                    Spacer()
                }
                if toastManager.isOpen {
                    Toast(
                        message: toastManager.toastMessage,
                        colorTheme: toastManager.colorTheme,
                        figureTheme: toastManager.figureTheme
                    )
                    .transition(animation.combined(with: .opacity))
                    .padding(.bottom, 30)
                    .padding(.top, 30)
                }
                if toastManager.alignment == .top {
                    Spacer()
                }
            }
        }
    }
    
    private var animation: AnyTransition {
        switch toastManager.alignment {
        case .top:
            return .move(edge: .top)
        case .bottom:
            return .move(edge: .bottom)
        }
    }
}
