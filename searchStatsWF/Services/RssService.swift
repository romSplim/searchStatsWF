//
//  RssService.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 07.06.2022.
//

import Foundation
import Alamofire
import AlamofireRSSParser

class RssService {
    let url = "https://ru.warface.com/rss.xml"
    
    func parseNews(completion: @escaping (RSSFeed) -> Void) {
        AF.request(url).responseRSS { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
}

