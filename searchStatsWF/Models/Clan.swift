//
//  SearchClanModel.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 28.03.2022.
//

import Foundation

struct Clan: Decodable {
    let id: String
    let name: String
    let members: [Member]
}

struct Member: Decodable {
    let nickname: String
    let rankID: String
    let clanPoints: String
    let clanRole: Role
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case rankID = "rank_id"
        case clanPoints = "clan_points"
        case clanRole = "clan_role"
    }
}

enum Role: String, Decodable {
    case regular = "REGULAR"
    case officer = "OFFICER"
    case master = "MASTER"
    
    func localize() -> String {
        switch self {
        case .regular:
            return "Рядовой"
        case .officer:
            return "Офицер"
        case .master:
            return "Глава"
        }
    }
}
