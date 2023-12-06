//
//  HomeScreen.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

struct HomeScreen: View {
    let goToDetail: () -> Void
    let present: () -> Void

    var body: some View {
        Button {
            goToDetail()
        } label: {
            Text("Go to detail")
        }
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    present()
                } label: {
                    Text("Present")
                }

            }
        }
    }
}
