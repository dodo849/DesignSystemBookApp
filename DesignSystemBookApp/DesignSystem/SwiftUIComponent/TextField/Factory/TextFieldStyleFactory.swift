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
    
    init(
        colorTheme: TextFieldColorTheme,
        figureTheme: TextFieldFigureTheme
    ) {
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        _TextFieldStyleMaker(
            configuration: configuration,
            colorTheme: colorTheme,
            figureTheme: figureTheme
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
    
    fileprivate init(
        configuration: TextField<Label>,
        colorTheme: TextFieldColorTheme,
        figureTheme: TextFieldFigureTheme
    ) {
        self.configuration = configuration
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
    
    var body: some View {
        let allState = makeAllState(state)
        let padding = figureTheme.padding()
        let animation = SwiftUIAnimationFactory.startInteract.make
        
        ZStack {
            configuration
                .padding(.vertical, padding.vertical)
                .padding(.horizontal, padding.horizontal)
                .background(colorTheme.backgroundColor(state: allState).color)
                .clipShape(figureTheme.shape())
                .overlay(overlay(allState))
                .foregroundColor(colorTheme.foregroundColor(state: allState).color)
                .font(.system(size: figureTheme.textSize()))
                .fontWeight(figureTheme.textWeight())
                .focused($isFocused)
                .animation(animation, value: allState)
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(colorTheme.bottomBorderColor(state: allState).color)
                    .frame(height: 2)
                    .animation(animation, value: allState)
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
            border(state).padding(1)
        }
    }
}

private extension _TextFieldStyleMaker {
    private func border(
        _ state: TextFieldAllState
    ) -> some View {
        figureTheme.shape()
            .stroke(
                colorTheme.borderColor(state: state).color,
                lineWidth: figureTheme.borderWidth()
            )
            .padding(figureTheme.borderWidth())
    }
}
