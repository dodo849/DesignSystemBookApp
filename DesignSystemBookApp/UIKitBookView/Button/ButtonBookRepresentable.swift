//
//  ButtonBookRepresentable.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/17/24.
//

import UIKit
import SwiftUI

struct ButtonBookRepresentable: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var parent: ButtonBookRepresentable

        init(parent: ButtonBookRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> ButtonBookViewController {
        return ButtonBookViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: ButtonBookViewController,
        context: Context
    ) {
        // Update the view here if needed
    }
}

struct ButtonBookRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBookRepresentable()
    }
}
