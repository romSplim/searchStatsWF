//
//  ListNewsPresenter.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 08.07.2022.
//

import Foundation
import AlamofireRSSParser

protocol ListNewsViewProtocol: AnyObject {
    func refreshUI()
}

protocol ListNewsPresenterProtocol: AnyObject {
    init(view: ListNewsViewProtocol, rssService: RssService, imageService: ImageService, router: RouterProtocol)
    var rssNews: RSSFeed? { get set }
    var newsImages: [String]? { get set }
    func getNewsInfo()
    func parsingImgNewUrl()
    func loadImageToCell(url: String, indexPath: IndexPath, completion: @escaping (UIImage) -> Void)
}
class ListNewsPresenter: ListNewsPresenterProtocol {
    
    weak private var view: ListNewsViewProtocol?
    
    let rssService: RssService?
    let imageService: ImageService?
    let router: RouterProtocol?
    var rssNews: RSSFeed?
    var newsImages: [String]?
    
    required init(view: ListNewsViewProtocol, rssService: RssService, imageService: ImageService, router: RouterProtocol) {
        self.view = view
        self.rssService = rssService
        self.imageService = imageService
        self.router = router
    }
    
    func getNewsInfo() {
        rssService?.parseNews { [weak self] news in
            guard let self = self else { return }
            self.rssNews = news
            self.view?.refreshUI()
        }
    }
    
    func parsingImgNewUrl() {
        SwiftSoupManager.shared.HtmlParse { [weak self] images in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.newsImages = images
                self.view?.refreshUI()
            }
        }
    }
    
    func loadImageToCell(url: String, indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        imageService?.fetchNewsImage(url: url, indexPath: indexPath) { image in
            if let image = image {
                completion(image)
            }
        }
    }
}


