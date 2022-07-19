//
//  ImageService.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 31.05.2022.
//

import UIKit

class ImageService {
    
    let cache = NSCache<NSNumber, UIImage>()
    
    func fetchNewsImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        let index = NSNumber(value: indexPath.row)
        if let cachedImage = cache.object(forKey: index) {
            completion(cachedImage)
            print("кэш")
        } else {
                URLSession.shared.dataTask(with: url) { (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            print("инет")
                            self.cache.setObject(image!, forKey: index)
                            completion(image)
                            print(index)
                        }
                    }
                }.resume()
        }
    }
}
