//
//  NerworkDataFetcher.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 14.06.2022.
//

import Foundation

class NetworkDataFetcher {
    private let networkService = NetworkService()
    
    func fetchPlayerData(serchTerm: String, completion: @escaping (Player?, ErrorPlayer?) -> Void) {
        networkService.playerRequest(searchTerm: serchTerm) { data, response ,error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (0...200):
                let decode = self.decodeJSON(type: Player.self, from: data)
                completion(decode,nil)
            case (201...400):
                let decode = self.decodeJSON(type: ErrorPlayer.self, from: data)
                completion(nil,decode)
            default:
                print("Dont know what its mean")
            }
        }
    }
    
    func fetchPlayerAchievement(serchTerm: String, completion: @escaping ([PlayerAchieves]?, ErrorPlayer?) -> Void) {
        networkService.playerAchievementRequest(searchTerm: serchTerm) { data, response ,error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (0...200):
                let decode = self.decodeJSON(type: [PlayerAchieves].self, from: data)
                completion(decode,nil)
            case (201...400):
                print("какая-то хуйня пришла")
            default:
                print("Dont know what its mean")
            }
        }
    }
    
    func fetchAllAchievement(completion: @escaping ([AllAchieves]?, ErrorPlayer?) -> Void) {
        networkService.allAchievementRequest() { data, response ,error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (0...200):
                let decode = self.decodeJSON(type: [AllAchieves].self, from: data)
                completion(decode,nil)
            case (201...400):
                print("какая-то хуйня пришла")
            default:
                print("Dont know what its mean")
            }
        }
    }
    
    func fetchClanStats(searchTerm: String, completion: @escaping (Clan?) -> Void) {
        networkService.clanStats(searchTerm: searchTerm) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case (0...200):
                let decode = self.decodeJSON(type: Clan.self, from: data)
                completion(decode)
            case (201...400):
                print("какая-то хуйня пришла")
                completion(nil)
            default:
                print("Dont know what its mean")
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let playerData = try decoder.decode(type, from: data)
            return playerData
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
    
    func decodeInMemoryJson() async -> [Achivement]? {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "jsonformatter", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let achievement = try? decoder.decode([Achivement].self, from: data) else { return nil }
        return achievement
    }
    //////////////////////////////////////////
    
    private func getPlayerAchieves(nickName: String) async -> [PlayerAchieves]  {
//        group.enter()
        var kekus = [PlayerAchieves]()
        self.fetchPlayerAchievement(serchTerm: nickName) { achieves, error in
            guard let achieves = achieves else {
//                group.leave()
                return
            }

//            completion(achieves)
            kekus = achieves
            print("Достяги персонажа получены")
//            group.leave()
        }
        return kekus
    }
    
    private func getAllAchieves() async -> [AllAchieves] {
//        group.enter()
        var kekus = [AllAchieves]()
        self.fetchAllAchievement { achieves, error in
            guard let achieves = achieves else {
//                group.leave()
                return
            }
//            completion(achieves)
            kekus = achieves
            print("Каталог достяг получен")
//            group.leave()
        }
        return kekus
    }
    
    func fetchAchievesAsyncAwait(nickName: String, completion: ([PlayerAchieves]?, [AllAchieves]?, [Achivement]?) -> Void ) async {
        let playerAchieves = await getPlayerAchieves(nickName: nickName)
        let allAchieves = await getAllAchieves()
        let allAchievesImages = await decodeInMemoryJson()
        completion(playerAchieves, allAchieves, allAchievesImages)
    }
    
//    private func notifyGroup(completion: @escaping ([Achivement]?) -> Void) {
//        guard let allAchievesImages = decodeInMemoryJson() else { return }
//        completion(allAchievesImages)
//    }
    
//    func testParseRefactor(nickName: String, completion: @escaping ([AllAchieves]?, [PlayerAchieves]?, [Achivement]?) -> Void ) {
//        let group = DispatchGroup()
//        var playerAchieves: [PlayerAchieves]?
//        var allAchives: [AllAchieves]?
//
//        getPlayerAchieves(nickName: nickName, group: group) { achieves in //Get current Player Achives
//            playerAchieves = achieves
//        }
//
//        getAllAchieves(group: group) { achieves in //Get list of all achieves
//                allAchives = achieves
//        }
//
//        group.notify(queue: .global()) {
//            self.notifyGroup() { achieveImage in //Get images url for achieves
//                if let achieveImage = achieveImage {
//                    completion(allAchives, playerAchieves, achieveImage)
//                }
//            }
//        }
//    }
}
    
    
    




