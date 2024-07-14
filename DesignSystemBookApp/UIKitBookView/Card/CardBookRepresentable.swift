//
//  CardBookRepresentable.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit
import SwiftUI

struct CardBookRepresentable: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var parent: CardBookRepresentable

        init(parent: CardBookRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> CardBookViewController {
        return CardBookViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: CardBookViewController,
        context: Context
    ) {
        // Update the view here if needed
    }
}

#Preview {
    CardBookRepresentable()
}

