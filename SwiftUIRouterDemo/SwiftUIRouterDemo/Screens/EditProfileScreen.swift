//
//  EditProfileScreen.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

struct EditProfileScreen: View {
    let dismiss: () -> Void

    var body: some View {
        NavigationStack {
            Text("Edit profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Dismiss")
                        }
                    }
                }
        }
    }
}
