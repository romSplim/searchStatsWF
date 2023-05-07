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
    func getNewsInfo(completion: @escaping () -> Void)
    func parsingImgNewUrl(completion: @escaping () -> Void)
    func dispatchGroupTask()
    func loadImageToCell(url: String, indexPath: IndexPath, completion: @escaping (UIImage) -> Void)
}

final class ListNewsPresenter: ListNewsPresenterProtocol {
    
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
    
    func getNewsInfo(completion: @escaping () -> Void ) {
        rssService?.parseNews { [weak self] news in
            guard let self else {
                completion()
                return
            }
            self.rssNews = news
            print("получаем новости")
            completion()
        }
    }
    
    func parsingImgNewUrl(completion: @escaping () -> Void ) {
        SwiftSoupManager.shared.htmlParse { [weak self] images in
            guard let self else {
                completion()
                return
            }
            print("получаем картинки к новостям")
                self.newsImages = images
            completion()
        }
    }
    
    func dispatchGroupTask() {
        let group = DispatchGroup()
        let qCuncurrent = DispatchQueue(label: "cuncurrent", attributes: .concurrent)
        group.enter()
        qCuncurrent.async(group: group) {
            print("News start")
            self.getNewsInfo {
                group.leave()
            }
        }
        group.enter()
        qCuncurrent.async(group: group) {
            print("Images start")
            self.parsingImgNewUrl {
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.view?.refreshUI()
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


