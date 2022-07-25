//
//  AchievesViewController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 19.06.2022.
//

import UIKit

final class AchievesViewController: UIViewController {
    
    var presenter: AchievesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .blue
        setConstraints()
        presenter?.showPlayerAchieves()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(nibName: ["AchivesCell"])
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
}

extension AchievesViewController: AchievesViewProtocol {
    func refreshUI() {
        tableView.reloadData()
    }
}

extension AchievesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.achieves?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AchivesCell", for: indexPath) as? AchivesCell,
              let achive = presenter?.achieves?[indexPath.row] else { return UITableViewCell()}
        cell.achieveLabel.text = achive.name
        cell.id = achive.image
        presenter?.imageService?.fetchNewsImage(url: achive.image, indexPath: indexPath) { image in
            if cell.id == achive.image {
                cell.achieveImg.image = image
            }
        }
        cell.numberProgress.text = presenter?.progressAchives?[indexPath.row].progress
        cell.dateLabel.text = presenter?.progressAchives?[indexPath.row].completionTime
        return cell
    }
    
    
}


