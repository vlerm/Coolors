//
//  ImageService.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import UIKit

class ImageService {
    
    static let shared = ImageService()
    static let pathURL = "http://api.imagga.com/v2"
    static let token = "Basic YWNjXzY0NWY3M2ZhZTViMGIyZjo0N2Y0OWVjZTI4N2ZjNmMyNmI2Y2UzZjIzNDNhMTgwYQ=="
    
    private init() {}
    
    func parseColors(imagePath: String, attempts: Int =  0, completion: @escaping ([UIColor]?) -> Void){
        guard let url = URL(string: ImageService.pathURL)?.appendingPathComponent("colors") else { completion(nil) ; return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "image_url", value: imagePath)]
        guard let fullUrl = components?.url else { completion(nil) ; return }
        var request = URLRequest(url: fullUrl)
        request.addValue(ImageService.token, forHTTPHeaderField: "Authorization")
        print(request.url?.absoluteString ?? "Nope")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                return
            }
            guard let data = data else {completion(nil) ; return}
            do {
                let decoder = JSONDecoder()
                let imageColorResponse = try decoder.decode(ImageColorResponse.self, from: data)
                let imageColors = imageColorResponse.result.colors.imageColors
                let colors = imageColors.compactMap{ UIColor($0) }
                completion(colors)
            } catch {
                if attempts < 2 {
                    return self.parseColors(imagePath: imagePath, attempts: attempts + 1, completion: completion)
                }
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
}
