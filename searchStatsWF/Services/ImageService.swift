//
//  ImageService.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 31.05.2022.
//

import UIKit

final class ImageService {
    
    let cache = NSCache<NSNumber, UIImage>()
    
    func fetchNewsImage(url: String, indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        let index = NSNumber(value: indexPath.row)
        if let cachedImage = cache.object(forKey: index) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.cache.setObject(image!, forKey: index)
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
