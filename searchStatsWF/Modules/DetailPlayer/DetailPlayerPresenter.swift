//
//  DetailPlayerPresenter.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import UIKit

protocol DetailPlayerViewProtocol: AnyObject {
    func showErrorMessage(_ message: String)
    func refreshUI()
}

protocol DetailPlayerPresenterProtocol: AnyObject {
    init(nickName: String, view: DetailPlayerViewProtocol, networkService: NetworkDataFetcher, storageManager: StorageManager, router: RouterProtocol)
    var nickName: String! { get set }
    var player: Player? { get set }
    var isPlayerFavorite: Bool { get set }
    var networkService: NetworkDataFetcher? { get }
    var storageManager: StorageManager? { get }
    var onCompletion: (((Player?, ErrorPlayer?)) -> Void)! { get set }
    func savePlayerInCoreData()
    func deleteFromCoreData(withNickName: String)
    func showAchieves() -> UIViewController
}
 
final class DetailPlayerPresenter: DetailPlayerPresenterProtocol {
   
    private weak var view: DetailPlayerViewProtocol?
    
    var networkService: NetworkDataFetcher?
    var storageManager: StorageManager?
    var router: RouterProtocol?
    
    let coreData = CoreDataStorage.shared
    var nickName: String!
    var player: Player?
    var isPlayerFavorite = false
    var onCompletion: (((Player?, ErrorPlayer?)) -> Void)!
    
    required init(nickName: String, view: DetailPlayerViewProtocol, networkService: NetworkDataFetcher, storageManager: StorageManager, router: RouterProtocol) {
        self.nickName = nickName
        self.view = view
        self.networkService = networkService
        self.storageManager = storageManager
        self.router = router
        getPlayerData(nickName: self.nickName ?? "")
    }
    
    func getPlayerData(nickName: String) {
        networkService?.fetchPlayerData(serchTerm: nickName) { [weak self] player, error in
            guard let self = self else { return }
            if let errorMessage = error?.message {
                self.view?.showErrorMessage(errorMessage)
            } else if let player = player {
                self.player = player
                self.isPlayerFavorite = (self.coreData.isItemFavorite(self.player?.nickname ?? ""))
                self.view?.refreshUI()
            }
        }
    }
    
    func recievingPlayerData() {
        onCompletion = { [weak self] data in
            guard let self = self else { return }
            if let errorMessage = data.1?.message {
                self.view?.showErrorMessage(errorMessage)
            } else if let player = data.0 {
                self.player = player
                self.isPlayerFavorite = (self.coreData.isItemFavorite(self.player?.nickname ?? ""))
                self.view?.refreshUI()
            }
        }
    }
    
    func savePlayerInCoreData() {
        let favPlayer = FavouritePlayer(nickName: player?.nickname, clanName: player?.clanName, rankImage: player?.rankID)
        CoreDataStorage.shared.save(favPlayer)
    }
    
    func deleteFromCoreData(withNickName: String) {
        let fetchRequest = FavoriteObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "nickName == %@", withNickName)
        let context = coreData.viewContext
        let object = try! context.fetch(fetchRequest)
        for obj in object {
            context.delete(obj)
        }
    }
    
    func showAchieves() -> UIViewController {
        guard let achievesVc = router?.showPlayerAchieves(nickName: nickName) else { return UIViewController() }
        return achievesVc
    }
    
    deinit {
        print("detail vc was deinited")
    }
}
