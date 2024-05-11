//
//  AsyncLoadImageView.swift
//  ImageViewer
//
//  Created by Sourav on 11/05/24.
//

import SwiftUI

struct AsyncLoadImageView: View {
    
    @StateObject var viewModel: AsyncLoadImageViewModel
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.loadImage()
        }
        .onDisappear {
            viewModel.cancelTask()
        }
    }
}
