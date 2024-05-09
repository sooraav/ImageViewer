//
//  ImageList.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import SwiftUI

struct ImageList: View {
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<100) { index in
                            GeometryReader { geometry in
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
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
    ImageList()
}
