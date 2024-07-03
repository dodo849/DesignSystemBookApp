//
//  DialogBookRepresentable.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit
import SwiftUI

struct DialogBookRepresentable: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var parent: DialogBookRepresentable

        init(parent: DialogBookRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> DialogBookViewController {
        return DialogBookViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: DialogBookViewController,
        context: Context
    ) {
        // Update the view here if needed
    }
}

#Preview {
    DialogBookRepresentable()
}
