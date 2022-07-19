//
//  Achivement.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 18.06.2022.
//

import Foundation

struct Achivement: Decodable {
    let name: String
    let image: String
}

struct PlayerAchieves: Decodable, Hashable {
    let id: String
    let progress: String
    let completionTime: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "achievement_id"
        case progress
        case completionTime = "completion_time"
    }
}

struct AllAchieves: Decodable {
    let id: String
    let name: String
}

struct TestAchieve: Decodable {
    let name: String?
    let id: String?
    let image: String?
    let date: String?
    let progress: String?
}
