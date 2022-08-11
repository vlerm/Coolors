//
//  UnsplashParser.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import Foundation
import UIKit

class UnsplashParser {
    
    static let shared = UnsplashParser()
    
    func parseFromUnsplash(for unsplashPath: UnsplashPath, completion: @escaping ([UnsplashImage]?) -> Void){
        guard let url = unsplashPath.customUrl else { return }
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            do {
                var unsplashImages: [UnsplashImage]!
                if unsplashPath == .searchPhotos {
                    let photoSearchDictionary = try JSONDecoder().decode(ImageSearchDictionary.self, from: data)
                    unsplashImages = photoSearchDictionary.results
                } else {
                    unsplashImages = try JSONDecoder().decode([UnsplashImage].self, from: data)
                }
                completion(unsplashImages)
            }catch {
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchImage(for unsplashImage: UnsplashImage, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: unsplashImage.urls.small) else { completion(nil) ; return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            completion(UIImage(data: data))
        }.resume()
    }
    
}
