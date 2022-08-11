//
//  ImageColor.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import Foundation

struct ImageColorResponse: Decodable {
    let result: ColorDictionaries
}

struct ColorDictionaries: Decodable {
    let colors: ColorResults
}

struct ColorResults: Decodable {
    let imageColors: [ImageColor]
    
    enum CodingKeys: String, CodingKey {
        case imageColors = "image_colors"
    }
}

struct ImageColor: Decodable {
    let red: Int
    let green: Int
    let blue: Int
    
    enum CodingKeys: String, CodingKey {
        case red = "r"
        case green = "g"
        case blue = "b"
    }
}
