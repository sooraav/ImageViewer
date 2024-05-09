//
//  HomeModel.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import Foundation

struct Base: Codable {
    let thumbnail: ThumbNail
}

struct ThumbNail: Codable {
    
    let domain: String
    let basePath: String
    let key: String
}
