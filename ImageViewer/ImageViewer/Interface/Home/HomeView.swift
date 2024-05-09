//
//  ContentView.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageUrls = viewModel.imageUrls {
                    
                    NavigationLink(destination: ImageList()) {
                        
                        Text("Go to ImageList")
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getData()
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
