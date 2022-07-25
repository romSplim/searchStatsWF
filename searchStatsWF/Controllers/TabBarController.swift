//
//  TabBarController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 16.03.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootControllers()
        setupTabBarAppearence()
        
        
    }
    
    func setupRootControllers() {
        let searchNavigationController = UINavigationController()
        let assembly = Assembly()
        let router = Router(navigationController: searchNavigationController, assemblyBuilder: assembly)
        router.initialSearchController()
        
//        viewController.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        let newsNavigationController = UINavigationController()

        let router2 = Router(navigationController: newsNavigationController, assemblyBuilder: assembly)
        router2.initialNewsController()
        
//        let newsController = ListNewsController()
//        newsController.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(systemName: "newspaper"), selectedImage: nil)
        
//        let navCotroller = UINavigationController(rootViewController: viewController)
        
        viewControllers = [searchNavigationController, newsNavigationController]
        
        
//        navCotroller.navigationBar.standardAppearance = setupNavbarColor()
//        navCotroller.navigationBar.scrollEdgeAppearance = setupNavbarColor()
//        secondNavController.navigationBar.standardAppearance = setupNavbarColor()
//        secondNavController.navigationBar.scrollEdgeAppearance = setupNavbarColor()
//        navCotroller.navigationItem.backButtonTitle = nil
//        secondNavController.navigationItem.backButtonTitle = nil
    }
    
    func setupNavbarColor() -> UINavigationBarAppearance {
        if #available(iOS 15, *) {
            let backImg = UIImage(named: "backImg")!.withTintColor(.myColor2, renderingMode: .alwaysOriginal)
            let appearance = UINavigationBarAppearance()
            appearance.setBackIndicatorImage(backImg, transitionMaskImage: backImg)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.myColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.myColor]
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            return appearance
        }
    }
    
    func setupTabBarAppearence() {
        tabBar.backgroundColor = .black
        tabBar.isTranslucent = false
        let appearence = UITabBarAppearance()
        appearence.backgroundColor = .black
        self.tabBar.scrollEdgeAppearance = appearence
        self.tabBar.standardAppearance = appearence
    }
}
