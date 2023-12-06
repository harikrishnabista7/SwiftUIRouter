//
//  PresentFromHome.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 06/12/23.
//

import SwiftUI

struct PresentedFromHome: View {
    let push: () -> Void
    var body: some View {
        Text("Hello world!")
            .navigationTitle("Presented from home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        push()
                    } label: {
                        Text("Push")
                    }
                }
            }
    }
}
