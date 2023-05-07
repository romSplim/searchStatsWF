//
//  DetailSearchController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 22.02.2022.
//

import UIKit
import CoreData

final class DetailSearchController: UIViewController {
    
    var presenter: DetailPlayerPresenterProtocol?

    var favBtnStateImg: UIImage {
        presenter?.isPlayerFavorite ?? false ? .fillStar : .emptyStar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootView()
        view.addSubview(tableView)
        setConstraints()
    }
    
    private func setupRootView() {
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
    }
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells(nibName: ["DetailCell", "SpecsCell", "MainSpecsCell"])
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
    private func addPlayerToFavourite(nickName: String, sender: UIButton) {
        if sender.currentImage == .emptyStar {
            presenter?.savePlayerInCoreData()
            sender.setImage(.fillStar, for: .normal)
        } else {
            presenter?.deleteFromCoreData(withNickName: nickName)
            sender.setImage(.emptyStar, for: .normal)
        }
    }
    
    func addHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        let gen2 = UIImpactFeedbackGenerator(style: .soft)
        gen2.impactOccurred()
    }
    
}

extension DetailSearchController: DetailPlayerViewProtocol {
    func showErrorMessage(_ message: String) {
        self.errorLabel.text = message
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
    }
    
    func refreshUI() {
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = false
    }
}

extension DetailSearchController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension DetailSearchController: DetailCellProtocol {
    func didTapProgressBtn(_ sender: UIButton) {
        let vc = ModalProgressViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: false)
    }
    
    func didTapFavBtn(_ sender: UIButton) {
        guard let nickName = presenter?.player?.nickname else { return }
        addPlayerToFavourite(nickName: nickName, sender: sender)
        addHapticFeedback()
    }
    
    func didTapAchievesBtn(_ sender: UIButton) {
        guard let achievesVc = presenter?.showAchieves() else { return }
        let navbar = UINavigationController(rootViewController: achievesVc)
        present(navbar, animated: true)
    }
    
    
    
}

