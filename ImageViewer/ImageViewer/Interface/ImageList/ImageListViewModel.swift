//
//  ImageListViewModel.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import Foundation

class ImageListViewModel: ObservableObject {
    
    let imageUrls: [String]
    
    init(imageUrls: [String]) {
        self.imageUrls = imageUrls
    }
    
}
