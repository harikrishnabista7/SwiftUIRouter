//
//  PushFromPresented.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 06/12/23.
//

import SwiftUI

struct PushedFromPresented: View {
    let dismiss: () -> Void

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle("Pushed from presented")
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
