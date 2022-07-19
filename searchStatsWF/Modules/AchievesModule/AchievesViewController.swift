//
//  AchievesViewController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 19.06.2022.
//

import UIKit

class AchievesViewController: UIViewController {
    
    let imageService = ImageService()
//    var doAfterCompletion: (([AllAchieves], [PlayerAchieves], [Achivement]) -> Void)!
    var achieves: [Achivement]?
    var progressAchives: [PlayerAchieves]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .blue
        setConstraints()
//        didRecievedAchivies()
    }

//    func didRecievedAchivies() {
//        doAfterCompletion = { all, player, imgs in
//            self.achieves = self.filteredAchieves(all: all, player: player, imgs: imgs)
//            self.progressAchives = player
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    
    private func filteredAchieves(all: [AllAchieves], player: [PlayerAchieves], imgs: [Achivement]) -> [Achivement] {
        let filteredAchievesNames = all.filter { achieve in
            return player.contains {
                $0.id == achieve.id
            }
        }
        
        let playerAchieveImage = imgs.filter { img in
            filteredAchievesNames.contains {
                $0.name == img.name
            }
        }
    return playerAchieveImage
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

extension AchievesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        achieves?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AchivesCell", for: indexPath) as? AchivesCell,
              let achive = achieves?[indexPath.row] else { return UITableViewCell()}
        cell.achieveLabel.text = achive.name
        cell.id = achive.image
        imageService.fetchNewsImage(url: achive.image, indexPath: indexPath) { image in
            if cell.id == achive.image {
                cell.achieveImg.image = image
            }
        }
        cell.numberProgress.text = progressAchives?[indexPath.row].progress
        cell.dateLabel.text = progressAchives?[indexPath.row].completionTime
        return cell
    }
    
    
}


