//
//  SettingsScreen.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

struct SettingsScreen: View {
    let editProfile: () -> Void
    
    var body: some View {
        List {
            Section {
                ForEach(0 ... 3, id: \.self) { index in
                    Text("\(index)")
                }
            } header: {
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Hari Krishna Bista")
                            .font(.title3)
                            .lineLimit(1)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    editProfile()
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}

