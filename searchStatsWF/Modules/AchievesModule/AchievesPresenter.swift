//
//  AchievesPresenter.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import Foundation

protocol AchievesViewProtocol: AnyObject {
    func refreshUI()
}

protocol AchievesPresenterProtocol: AnyObject {
    init(nickName: String, view: AchievesViewProtocol, networkService: NetworkDataFetcher, imageService: ImageService)
    var nickName: String! { get set }
    var networkService: NetworkDataFetcher! { get }
    var imageService: ImageService! { get }
    var achieves: [Achivement]? { get set }
    var progressAchives: [PlayerAchieves]? { get set }
    func showPlayerAchieves()
}

final class AchievesPresenter: AchievesPresenterProtocol {
    
    private weak var view: AchievesViewProtocol?
    
    var nickName: String!
    let networkService: NetworkDataFetcher!
    let imageService: ImageService!
    var achieves: [Achivement]?
    var progressAchives: [PlayerAchieves]?
    
    required init(nickName: String, view: AchievesViewProtocol, networkService: NetworkDataFetcher, imageService: ImageService) {
        self.nickName = nickName
        self.view = view
        self.networkService = networkService
        self.imageService = imageService
    }
    
    func showPlayerAchieves() {
        networkService?.testParseRefactor(nickName: self.nickName) { [weak self] allAchieves, playerAchieves, imgs in
            guard let self = self,
                  let playerAchieves = playerAchieves,
                  let allAchieves = allAchieves,
                  let imgs = imgs else { return }
            self.achieves = self.filteredAchieves(all: allAchieves, player: playerAchieves, imgs: imgs)
            self.progressAchives = playerAchieves
            DispatchQueue.main.async {
                self.view?.refreshUI()
                print("Таблица обновлена")
            }
        }
    }
    
    private func filteredAchieves(all: [AllAchieves], player: [PlayerAchieves], imgs: [Achivement]) -> [Achivement] {
        let filteredAchievesNames = all.filter { achieve in
            player.contains {
                $0.id == achieve.id
            }
        }
        print(filteredAchievesNames)
        let playerAchieveImage = imgs.filter { img in
            filteredAchievesNames.contains {
                $0.name == img.name
            }
        }
        return playerAchieveImage
    }
    
}
