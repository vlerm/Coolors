//
//  UnsplashPath.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import Foundation

enum UnsplashPath {
    
    static let stringUrl = "https://api.unsplash.com/"
    static let clientId = "eYF-rzW776nic2O-HgC1Ee_gocdleMtcIb3n5FbxLjg"
    
    case photosRandom
    case photos
    case searchPhotos
    
    var path: String {
        switch self {
        case .photosRandom:
            return "/photos/random"
        case .photos:
            return "/photos/"
        case .searchPhotos:
            return "/search/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "client_id", value: UnsplashPath.clientId),
            URLQueryItem(name: "count", value: "15")
        ]
        switch self {
        case .photosRandom, .photos:
            return items
        case .searchPhotos:
            items.append(URLQueryItem(name: "query", value: "double rainbow"))
            return items
        }
    }
    
    var customUrl: URL? {
        guard let url = URL(string: UnsplashPath.stringUrl)?.appendingPathComponent(path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components?.url
    }
    
}

