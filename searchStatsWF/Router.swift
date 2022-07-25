//
//  Router.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 09.07.2022.
//

import UIKit

protocol RouterProtocol {
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol)
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyProtocol? { get set }
    func initialSearchController()
    func showPlayerDetail(nickName: String)
    func showClanDetail(clanName: String)
    func showPlayerAchieves(nickName: String)
    func popToRoot()
}

final class Router: RouterProtocol {
    required init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyProtocol?
    
    func initialSearchController() {
        guard let navigationController = navigationController,
              let searchVc = assemblyBuilder?.createSearchModule(router: self) else { return }
        searchVc.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        navigationController.viewControllers = [searchVc]
    }
    
    func initialNewsController() {
        guard let navigationController = navigationController,
              let newsController = assemblyBuilder?.createListNewsModule(router: self) else { return }
        newsController.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(systemName: "newspaper"), selectedImage: nil)
        navigationController.viewControllers = [newsController]
    }
    
    func showPlayerDetail(nickName: String) {
        guard let navigationController = navigationController,
              let playerDetailVc = assemblyBuilder?.createPlayerDetailModule(router: self, nickName: nickName) else { return }

            navigationController.pushViewController(playerDetailVc, animated: true)
    }
    
    func showClanDetail(clanName: String) {
        guard let navigationController = navigationController,
              let clanDetailVc = assemblyBuilder?.createClanDetailModule(router: self, clanName: clanName) else { return }

            navigationController.pushViewController(clanDetailVc, animated: true)
    }
    
    func showPlayerAchieves(nickName: String) {
        guard let navigationController = navigationController,
              let playerAchievesVc = assemblyBuilder?.createAchievesModule(router: self, nickName: nickName) else { return }

            navigationController.pushViewController(playerAchievesVc, animated: true)
    }
    
    func popToRoot() {
         
    }
    
    
    
}
