//
//  HomeDetailScreen.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

struct HomeDetailScreen: View {
    let goBack: () -> Void
    var body: some View {
        VStack {
            Text("Home detail")
            Button {
                goBack()
            } label: {
                Text("Go back")
            }
        }
        .navigationTitle("Detail")
    }
}
