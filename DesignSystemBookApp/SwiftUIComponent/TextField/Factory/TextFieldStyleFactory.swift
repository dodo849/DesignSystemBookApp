//
//  TextFieldStyleFactory.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/15/24.
//

import SwiftUI

struct TextFieldStyleFactory: TextFieldStyle {
    private let colorTheme: TextFieldColorTheme
    private let figureTheme: TextFieldFigureTheme
    private let variant: BasicTextFieldVariant
    
    init(
        colorTheme: TextFieldColorTheme,
        figureTheme: TextFieldFigureTheme,
        variant: BasicTextFieldVariant
    ) {
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
        self.variant = variant // Injection for underline
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        _TextFieldStyleMaker(
            configuration: configuration,
            colorTheme: colorTheme,
            figureTheme: figureTheme,
            variant: variant
        )
    }
}

private struct _TextFieldStyleMaker<Label>: View where Label: View {
    typealias Configuration = TextField<Label>
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool
    @Environment(\.textFieldState) private var state: TextFieldState
    
    private let configuration: Configuration
    private let colorTheme: TextFieldColorTheme
    private let figureTheme: TextFieldFigureTheme
    private let variant: BasicTextFieldVariant
    
    fileprivate init(
        configuration: TextField<Label>,
        colorTheme: TextFieldColorTheme,
        figureTheme: TextFieldFigureTheme,
        variant: BasicTextFieldVariant
    ) {
        self.configuration = configuration
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
        self.variant = variant // Injection for underline
    }
    
    var body: some View {
        let allState = makeAllState(state)
        let padding = figureTheme.padding()
        let animation = SwiftUIAnimationFactory.startInteract.make
        
        ZStack {
            configuration
                .padding(.vertical, padding.vertical)
                .padding(.horizontal, isUnderlined ? 0 : padding.horizontal)
                .background(colorTheme.backgroundColor(state: allState))
                .clipShape(figureTheme.shape())
                .overlay(overlay(allState))
                .foregroundColor(colorTheme.foregroundColor(state: allState))
                .font(.system(size: figureTheme.textSize()))
                .fontWeight(figureTheme.textWeight())
                .focused($isFocused)
                .animation(animation, value: allState)
            
            if isUnderlined {
                VStack {
                    Spacer()
                    Divider()
                        .frame(height: 1)
                        .background(colorTheme.borderColor(state: allState))
                }
            }
            
            // Designate the padding area of the text field as a touch target
            Color.none
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
        }
    }
}

private extension  _TextFieldStyleMaker {
    private func makeAllState(_ inputState: TextFieldState) -> TextFieldAllState {
        if !isEnabled {
            return .disabled
        }
        
        // If in error or success state, do not change to focus color
        if isFocused && state != .error && state != .success {
            return .focused
        }
        
        if let convertedState = TextFieldAllState.init(rawValue: inputState.rawValue) {
            return convertedState
        } else {
            fatalError("TextFieldAllState and TextFieldState(\(inputState.rawValue) is mismatch")
        }
    }
    
    private func overlay(
        _ state: TextFieldAllState
    ) -> some View {
        Group {
            if !isUnderlined {
                border(state).padding(1)
            }
        }
    }
}

private extension _TextFieldStyleMaker {
    private func border(
        _ state: TextFieldAllState
    ) -> some View {
        figureTheme.shape()
            .stroke(
                colorTheme.borderColor(state: state),
                lineWidth: figureTheme.borderWidth()
            )
            .padding(figureTheme.borderWidth())
    }
}

private extension _TextFieldStyleMaker {
    private var isUnderlined: Bool {
        return variant == .underlined
    }
}
