//
//  TextFieldBookRepresentable.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit
import SwiftUI

struct TextFieldBookRepresentable: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var parent: TextFieldBookRepresentable

        init(parent: TextFieldBookRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> TextFieldBookViewController {
        return TextFieldBookViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: TextFieldBookViewController,
        context: Context
    ) {
        // Update the view here if needed
    }
}

struct TextFieldBookRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBookRepresentable()
    }
}
