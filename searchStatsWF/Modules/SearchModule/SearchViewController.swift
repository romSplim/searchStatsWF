//
//  ViewController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 13.02.2022.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    var presenter: SearchViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootView()
        setConstraints()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.restoreFavFromStorage()
    }
  
    func setupRootView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        self.title = "Cтатистика"
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(nibName: ["FavoriteCell"])
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    func setConstraints() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func pushPlayerDetailVC(nickName: String) {
        presenter?.showPlayerDetail(nickName: nickName)
    }
    
    func pushClanDetailVC(clanName: String) {
        presenter?.showClanDetail(clanName: clanName)
    }
}
//Presenter Delegate
extension SearchViewController: SearchViewProtocol {
    
    func tableViewDeleteRows(_ byIndex: IndexPath) {
        tableView.deleteRows(at: [byIndex], with: .fade)
        tableView.reloadData()
    }
    
    func refreshUI() {
        tableView.reloadData()
    }
}

//MARK: - TableView DataSource, Delegate

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favoritePlayers?.count ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell" , for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        let favoritePlayer = presenter?.favoritePlayers?[indexPath.row]
        let imageStorage = presenter?.storageManager?.ranksImgs
        cell.setupCell(with: favoritePlayer, images: imageStorage)
        cell.startShimmeringAnimation()
        cell.stopShimmeringAnimation()
        return cell
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView(title: "Отслеживаемые")
        header.dataSource = self
        return header
    }
    
//Delete Player from CoreData
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteFromCoreData(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let searchText = presenter?.favoritePlayers?[indexPath.row].nickName {
           pushPlayerDetailVC(nickName: searchText)
        }
    }
}

//MARK: - UISearchBar Delegate methods
enum ScopeItems: String {
    case players = "Персонажи"
    case clans = "Кланы"
    
    var placeholderText: String {
        switch self {
        case .players:
            return "Введите имя персонажа"
        case .clans:
            return "Введите название клана"
        }
    }

}


extension SearchViewController: UISearchBarDelegate {
    func setupSearchController() {
        let searchController = UISearchController()
        let searchBar = searchController.searchBar
//        let items: [ScopeItems] = [.players, .clans]
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = [ScopeItems.players.rawValue, ScopeItems.clans.rawValue]
        searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchBar.placeholder = searchBar.scopeButtonTitles![selectedScope]
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let typedText = searchBar.text else { return }
        searchBar.selectedScopeButtonIndex == 0 ? pushPlayerDetailVC(nickName: typedText) : pushClanDetailVC(clanName: typedText)
        
    }
}

extension SearchViewController: HeaderViewDataSource {
    func numberOfTrackingPlayers(_ inView: UIView) -> Int {
        return presenter?.favoritePlayers?.count ?? 0
    }
}
