//
//  Assembly.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import UIKit

protocol AssemblyProtocol {
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createPlayerDetailModule(router: RouterProtocol, nickName: String) -> UIViewController
    func createClanDetailModule(router: RouterProtocol, clanName: String) -> UIViewController
    func createAchievesModule(router: RouterProtocol, nickName: String) -> UIViewController
    func createListNewsModule(router: RouterProtocol) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let networkSevice = NetworkDataFetcher()
        let storeManager = StorageManager()
        let presenter = SearchViewPresenter(view: view, networkService: networkSevice, storageManager: storeManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createPlayerDetailModule(router: RouterProtocol, nickName: String) -> UIViewController {
        let view = DetailSearchController()
        let networkSevice = NetworkDataFetcher()
        let storeManager = StorageManager()
        let presenter = DetailPlayerPresenter(nickName: nickName, view: view, networkService: networkSevice, storageManager: storeManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createClanDetailModule(router: RouterProtocol, clanName: String) -> UIViewController {
        let view = DetailClanTableViewController()
        let networkSevice = NetworkDataFetcher()
        let storeManager = StorageManager()
        let presenter = DetailClanPresenter(view: view, clanName: clanName, networkService: networkSevice, ranksStorage: storeManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAchievesModule(router: RouterProtocol, nickName: String) -> UIViewController {
        let view = AchievesViewController()
        let networkSevice = NetworkDataFetcher()
        let imageService = ImageService()
        let presenter = AchievesPresenter(nickName: nickName, view: view, networkService: networkSevice, imageService: imageService)
        view.presenter = presenter
        return view
    }
    
    func createListNewsModule(router: RouterProtocol) -> UIViewController {
        let view = ListNewsController()
        let rssService = RssService()
        let imageService = ImageService()
        let presenter = ListNewsPresenter(view: view, rssService: rssService, imageService: imageService, router: router)
        view.presenter = presenter
        return view
    }
}
