//
//  DetailSearchController+Extension.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 18.05.2022.
//

import UIKit

//MARK: - TableView DataSource, Delegate

extension DetailSearchController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections = 0
        if presenter?.player != nil {
            numOfSections = 4
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView  = errorLabel
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 8
        default:
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell,
                  let player = presenter?.player,
                  let imageStorage = presenter?.storageManager?.ranksImgs else { return UITableViewCell()}
            cell.delegate = self
            cell.setupCell(with: player, images: imageStorage)
            cell.favoriteButton.setImage(favBtnStateImg, for: .normal)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSpecsCell", for: indexPath) as? MainSpecsCell else { return UITableViewCell() }
            cell.myCollectionView.dataSource = self
            cell.myCollectionView.delegate = self
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpecsCell", for: indexPath) as? SpecsCell,
                  let player = presenter?.player else { return UITableViewCell() }
            cell.setupCell(with: player, indexPath: indexPath)
            return cell
        }
    }
}
//MARK: - UITableView Delegate methods
extension DetailSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            return HeaderView(title: "PVP")
        case 3:
            return HeaderView(title: "PVE")
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = section == 0 || section == 1 ? 0 : 40
        return height
    }
}

//MARK: - UICollectionView DataSource methods

extension DetailSearchController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HugeSpecsCell", for: indexPath) as? HugeSpecsCell,
              let player = presenter?.player else { return UICollectionViewCell() }
        cell.setupCell(model: player, indexPath: indexPath)
        return cell
    }
    //MARK: - UICollectionView DelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width / 3) - 25
        return CGSize(width: width, height: width)
    }
}

extension DetailSearchController: UIGestureRecognizerDelegate {
    func a() -> UIGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(nextRankTapped))
        gesture.delegate = self
        return gesture
    }
}
