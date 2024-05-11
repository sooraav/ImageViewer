//
//  ImageList.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import SwiftUI

struct ImageList: View {
    
    @StateObject var viewModel: ImageListViewModel
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.imageUrls, id: \.self) { url in
                            GeometryReader { geometry in
                                AsyncLoadImageView(viewModel: AsyncLoadImageViewModel(url: url))
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(10)
                }
                .navigationBarTitle("Image Grid")
            }
    }

#Preview {
    ImageList(viewModel: ImageListViewModel(imageUrls: []))
}
