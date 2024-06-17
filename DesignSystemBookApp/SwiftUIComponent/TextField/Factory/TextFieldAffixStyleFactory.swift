//
//  TextFieldAffixStyleFactory.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

struct TextFieldSuffixStyleFactory<Suffix: View>: TextFieldStyle {
    private let suffix: () -> Suffix
    
    init(
        @ViewBuilder suffix: @escaping () -> Suffix
    ) {
        self.suffix = suffix
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        HStack {
            configuration
            suffix()
        }
    }
}

struct TextFieldPrefixStyleFactory<Prefix: View>: TextFieldStyle {
    private let prefix: () -> Prefix
    
    init(
        @ViewBuilder prefix: @escaping () -> Prefix
    ) {
        self.prefix = prefix
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        HStack {
            prefix()
            configuration
        }
    }
}
