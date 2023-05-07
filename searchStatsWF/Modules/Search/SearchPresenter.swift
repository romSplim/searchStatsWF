//
//  SearchPresenter.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func refreshUI()
    func tableViewDeleteRows(_ byIndex: IndexPath)
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: NetworkDataFetcher, storageManager: StorageManager, router: RouterProtocol)
    var favoritePlayers: [FavoriteObject]? { get set }
    var networkService: NetworkDataFetcher? { get set }
    var storageManager: StorageManager? { get set }
    func fetchFavoritePlayers()
//    func deleteFromFavorite(indexPath: IndexPath)
    func deleteFromFavorite(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle)
    func showPlayerDetail(nickName: String)
    func showClanDetail(clanName: String)
}

final class SearchViewPresenter: SearchViewPresenterProtocol {
  
    private weak var view: SearchViewProtocol?
    
    var router: RouterProtocol?
    var networkService: NetworkDataFetcher?
    var storageManager: StorageManager?
    var favoritePlayers: [FavoriteObject]? {
        didSet {
            favoritePlayers?.reverse()
        }
    }
    
    required init(view: SearchViewProtocol, networkService: NetworkDataFetcher, storageManager: StorageManager, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.storageManager = storageManager
        self.router = router
    }
    
    func fetchFavoritePlayers() {
        CoreDataStorage.shared.fetchData { result in
            switch result {
            case .success(let stats):
                favoritePlayers = stats
                view?.refreshUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteFromFavorite(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle) {
        guard editingStyle == .delete else { return }
        CoreDataStorage.shared.delete(favoritePlayers?[indexPath.row] ?? FavoriteObject())
        favoritePlayers?.remove(at: indexPath.row)
        view?.tableViewDeleteRows(indexPath)
    }
    
    func showPlayerDetail(nickName: String) {
        self.router?.showPlayerDetail(nickName: nickName)
    }
    
    func showClanDetail(clanName: String) {
        self.router?.showClanDetail(clanName: clanName)
    }

}
