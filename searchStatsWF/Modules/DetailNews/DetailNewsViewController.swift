//
//  DetailNewsViewController.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 18.03.2022.
//

import UIKit
import WebKit

final class DetailNewsViewController: UIViewController {

    var urlCurrentNews = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        addSubviews()
        setupLayout()
        loadNews()
    }
    
    private func addSubviews() {
        view.addSubview(webView)
    }
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.scrollView.backgroundColor = .black
        return webView
    }()
    
    
    func loadNews() {
        guard let url = URL(string: urlCurrentNews) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func setupLayout() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailNewsViewController: DetailNewsViewProtocol {
    
}
