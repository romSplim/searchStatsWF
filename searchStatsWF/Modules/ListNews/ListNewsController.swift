//
//  ListNewsControllerNew.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 25.04.2022.
//

import UIKit
import SkeletonView
import AlamofireRSSParser

final class ListNewsController: UIViewController {
    
    var presenter: ListNewsPresenterProtocol?
    
    var refreshIndicator = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showSkeleton(usingColor: .red, animated: true, delay: 1, transition: .crossDissolve(0.25))
        setupRootView()
        setupTableView()
        setupLayout()
        presenter?.dispatchGroupTask()
    }
    
    private func setupRootView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backItem?.backButtonDisplayMode = .minimal
        title = "Новости"
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(nibName: ["NewsCell", "LoadingCell"])
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 280
        tableView.isSkeletonable = true
        tableView.backgroundColor = .black
        tableView.showAnimatedGradientSkeleton()
        
    }
}

extension ListNewsController: ListNewsViewProtocol {
    func refreshUI() {
        self.tableView.reloadData()
        self.tableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}

// MARK: - Table view data source
extension ListNewsController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rssNews?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell,
              let currentAtricle = presenter?.rssNews?.items[indexPath.row],
              let currentImage = presenter?.newsImages?[indexPath.row] else { return UITableViewCell()}
        cell.id = currentImage
        cell.setupCell(item: currentAtricle)
        
        presenter?.loadImageToCell(url: currentImage, indexPath: indexPath) { image in
            if currentImage == cell.id {
                cell.newsImage.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = presenter?.rssNews?.items[indexPath.row].link else { return }
        let detailNewsVc = DetailNewsViewController()
        detailNewsVc.urlCurrentNews = news
        self.navigationController?.pushViewController(detailNewsVc, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsCell"
    }
}
