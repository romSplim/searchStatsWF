//
//  News.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 28.04.2022.
//

import Foundation

struct News {
    var title: String
    var description: String
    var imageURL: String
    var newsLink: String
    
    init() {
        title = ""
        description = ""
        imageURL = ""
        newsLink = ""
    }
    
    init(title: String, description: String, imageURL: String, newsLink: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.newsLink = newsLink
    }
}


