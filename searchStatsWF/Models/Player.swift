//
//  SearchModel.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 13.02.2022.
//

import Foundation

struct Player: Codable {
    let userID: String
    let nickname: String
    let experience, rankID: Int
    let isTransparent: Bool
    let clanID: Int?
    let clanName: String?
    let kill, friendlyKills, kills, death: Int
    let pvp: Double
    let pveKill, pveFriendlyKills, pveKills, pveDeath: Int
    let pve: AnyCodable
    let playtime, playtimeH, playtimeM: Int
    let favoritPVP, favoritPVE: AnyCodable
    let pveWINS, pvpWINS, pvpLost, pveLost: Int
    let pveAll, pvpAll: Int
    let pvpwl: Double

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nickname, experience
        case rankID = "rank_id"
        case isTransparent = "is_transparent"
        case clanID = "clan_id"
        case clanName = "clan_name"
        case kill
        case friendlyKills = "friendly_kills"
        case kills, death, pvp
        case pveKill = "pve_kill"
        case pveFriendlyKills = "pve_friendly_kills"
        case pveKills = "pve_kills"
        case pveDeath = "pve_death"
        case pve, playtime
        case playtimeH = "playtime_h"
        case playtimeM = "playtime_m"
        case favoritPVP, favoritPVE
        case pveWINS = "pve_wins"
        case pvpWINS = "pvp_wins"
        case pvpLost = "pvp_lost"
        case pveLost = "pve_lost"
        case pveAll = "pve_all"
        case pvpAll = "pvp_all"
        case pvpwl
    }
}

enum GameClass: String, Codable {
    case rifleman = "Rifleman"
    case medic = "Medic"
    case engineer = "Engineer"
    case recon = "Recon"
    case sed = "SED"
   
    
    func localize() -> String {
        switch self {
        case .rifleman:
            return "Штурмовик"
        case .medic:
            return "Медик"
        case .engineer:
            return "Инженер"
        case .recon:
            return "Снайпер"
        case .sed:
            return "Сэд"
        }
    }
}

enum AnyCodable {
    case string(value: String)
    case int(value: Int)
    case data(value: Data)
    case double(value: Double)
    case bool(value: Bool)
    
    func toString() -> String? {
        switch self {
        case .string(value: let value):
            return value
        case .int(value: let value):
            return "\(value)"
        case .data(value: let value):
            return String(decoding: value, as: UTF8.self)
        case .double(value: let value):
            return "\(value)"
        case .bool(value: let value):
            return "\(value)"
        }
    }
    
    enum AnyCodableError:Error {
        case missingValue
    }
}

extension AnyCodable: Codable {
    
    enum CodingKeys: String, CodingKey {
        case string, int, data, double, bool
    }
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(value: int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(value: string)
            return
        }
        
        if let data = try? decoder.singleValueContainer().decode(Data.self) {
            self = .data(value: data)
            return
        }

        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(value: double)
            return
        }
        
        if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(value: bool)
            return
        }
        
        throw AnyCodableError.missingValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .data(let value):
            try container.encode(value, forKey: .data)
        case .double(let value):
            try container.encode(value, forKey: .double)
        case .bool(let value):
            try container.encode(value, forKey: .bool)
        }
    }
}





