//
//  TestNetworkService.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 13.06.2022.
//

import Foundation

final class NetworkService {
    //Requests
    func playerRequest(searchTerm: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameters = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.playerUrl(params: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let task = createDataTask(from: urlRequest, coompletion: completion)
        task.resume()
    }
    
    func playerAchievementRequest(searchTerm: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameters = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.playerAchievementUrl(params: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let task = createDataTask(from: urlRequest, coompletion: completion)
        task.resume()
    }
    
    func allAchievementRequest(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = self.allAchievementUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let task = createDataTask(from: urlRequest, coompletion: completion)
        task.resume()
    }
    
    func clanStats(searchTerm: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let parameters = self.parametersForClanUrl(searchTerm: searchTerm)
        let url = self.clanStatsUrl(params: parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let task = createDataTask(from: urlRequest, coompletion: completion)
        task.resume()
    }
//Parameters
    private func prepareParametrs(searchTerm: String?) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["name"] = searchTerm
        print(parametrs)
        return parametrs
    }
    
    private func parametersForClanUrl(searchTerm: String?) -> [String: String] {
        var parametrs = [String: String]()
        parametrs["clan"] = searchTerm
        print(parametrs)
        return parametrs
    }
// URL components
    private func playerUrl(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.warface.ru"
        components.path = "/user/stat"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func playerAchievementUrl(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.warface.ru"
        components.path = "/user/achievements"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func allAchievementUrl() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.warface.ru"
        components.path = "/achievement/catalog"
        return components.url!
    }
    
    private func clanStatsUrl(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.warface.ru"
        components.path = "/clan/members"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    //Data task
    private func createDataTask(from request: URLRequest, coompletion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                coompletion(data, response, error)
            }
        }
    }
}


