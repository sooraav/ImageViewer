//
//  ContentView.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: ImageList()) {
                    
                Text("Go to ImageList")
                }
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
