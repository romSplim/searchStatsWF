//
//  DetailClanTableViewControllerNew.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 25.04.2022.
//

import UIKit
import SkeletonView

final class DetailClanTableViewController: UIViewController {
    
    var presenter: DetailClanPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        makeConstraints()
        tableView.registerCells(nibName: ["SearchClanCell", "ClanNameCell"])
    }
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Клана с таким названием не существует"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldFont(size: 18)
        label.textColor = .myColor
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.contentMode = .center
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        return indicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    func makeConstraints() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    func pushPlayerDetailVC(nickName: String) {
        presenter?.showPlayerDetailModule(nickName: nickName)
    }
}

extension DetailClanTableViewController: DetailClanViewProtocol {
    func refreshUI() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
}

// MARK: - TableView Data source
extension DetailClanTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if presenter?.clan != nil {
            numOfSections = 2
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = errorLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = section == 0 ? 1 : presenter?.clan?.members.count ?? 0
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClanNameCell", for: indexPath) as? ClanNameCell,
                  let clan = presenter?.clan else { return UITableViewCell() }
            cell.configure(with: clan)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchClanCell", for: indexPath) as? SearchClanCell,
                  let clan = presenter?.clan,
                  let ranks = presenter?.ranks?.ranksImgs else { return UITableViewCell() }
            cell.setupCell(model: clan, indexPath: indexPath, ranks: ranks)
            return cell
        }
    }
//TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let playerNickname = presenter?.clan?.members[indexPath.row].nickname {
            pushPlayerDetailVC(nickName: playerNickname)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 1 ? HeaderView(title: "Состав клана") : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = section == 0 ? 0 : 30
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = indexPath.section == 1 ? 55 : UITableView.automaticDimension
        return height
    }
}

extension DetailClanTableViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SearchClanCell"
    }
}
