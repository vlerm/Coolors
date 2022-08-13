//
//  UnsplashImage.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import Foundation

struct ImageSearchDictionary: Decodable {
    let results: [UnsplashImage]
}

struct UnsplashImage: Decodable {
    let urls: URLGroup
    let description: String?
}

struct URLGroup: Decodable {
    let small: String
    let regular: String
}
