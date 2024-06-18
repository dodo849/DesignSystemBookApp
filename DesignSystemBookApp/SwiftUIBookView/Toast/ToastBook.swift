//
//  ToastBook.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/18/24.
//

import SwiftUI

struct ToastBook: View {
    var body: some View {
        VStack {
            Button {
                ToastManager.shared.showToast(message: "Toast test")
            } label: {
                Text("show toast")
                    .typo(.body1b)
            }
            .styled(variant: .translucent, color: .ghost)
        }
        .padding(pagePadding)
    }
}

#Preview {
    ToastBook()
}
