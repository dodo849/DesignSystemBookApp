//
//  SegmentControlBookRepresentable.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import UIKit
import SwiftUI

struct SegmentControlBookRepresentable: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var parent: SegmentControlBookRepresentable

        init(parent: SegmentControlBookRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> SegmentControlBookViewController {
        return SegmentControlBookViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: SegmentControlBookViewController,
        context: Context
    ) {
        // Update the view here if needed
    }
}

struct SegmentControlRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlBookRepresentable()
    }
}
