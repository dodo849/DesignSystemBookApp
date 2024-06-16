//
//  TextFieldWithAffix.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import SwiftUI

//struct TextFieldWithAffix<Prefix: View, Suffix: View>: View {
//    private let prefix: Prefix?
//    private let suffix: Suffix?
//    
//    init(
//        @ViewBuilder prefix: (() -> Prefix)? = nil,
//        @ViewBuilder suffix: (() -> Suffix)? = nil
//    ) {
//        self.prefix = prefix?()
//        self.suffix = suffix?()
//    }
//    
//    var body: some View {
//        HStack {
//            GeometryReader { prefixGeometry in
//                if let prefix = prefix {
//                    prefix
//                }
//            }
//            TextField("Placeholder", text: .constant(""))
//            GeometryReader { suffixGeometry in
//                if let suffix = suffix {
//                    suffix
//                }
//            }
//        }
//    }
//}
//
//struct WidthPreferenceSetter<Key: PreferenceKey>: View where Key.Value == CGFloat {
//    let key: Key.Type
//    
//    var body: some View {
//        GeometryReader { geometry in
//            Color.clear
//                .preference(key: key, value: geometry.size.width)
//        }
//    }
//}
