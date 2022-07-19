//
//  DetailClanPresenter.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import Foundation

protocol DetailClanViewProtocol: AnyObject {
    func refreshUI()
}

protocol DetailClanPresenterProtocol: AnyObject {
    init(view: DetailClanViewProtocol, clanName: String, networkService: NetworkDataFetcher, ranksStorage: StorageManager, router: RouterProtocol)
    var clan: Clan? { get set }
    var ranks: StorageManager? { get }
    func showPlayerDetailModule(nickName: String)
    func loadClanDetail(clanName: String)
}

class DetailClanPresenter: DetailClanPresenterProtocol {
    
    weak private var view: DetailClanViewProtocol?
    
    var clanName: String?
    let networkService: NetworkDataFetcher?
    let router: RouterProtocol?
    let ranks: StorageManager?
    var clan: Clan?
    
    required init(view: DetailClanViewProtocol, clanName: String, networkService: NetworkDataFetcher, ranksStorage: StorageManager, router: RouterProtocol) {
        self.view = view
        self.clanName = clanName
        self.networkService = networkService
        self.ranks = ranksStorage
        self.router = router
        loadClanDetail(clanName: self.clanName ?? "")
    }
    
    func loadClanDetail(clanName: String) {
        networkService?.fetchClanStats(searchTerm: clanName) { [weak self] clan in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.clan = clan
                self.view?.refreshUI()
            }
        }
    }
    
    func showPlayerDetailModule(nickName: String) {
        self.router?.showPlayerDetail(nickName: nickName)
    }
    
}

 
