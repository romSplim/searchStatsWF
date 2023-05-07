//
//  SwiftSoup.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 16.03.2022.


import UIKit
import SwiftSoup

final class SwiftSoupManager {
    
    static let shared = SwiftSoupManager()

    func htmlParse(completion: @escaping ([String]) -> Void) {
        DispatchQueue.global().async {
            guard let myURL = URL(string: "https://ru.warface.com/news/"),
                  let html = try? String(contentsOf: myURL, encoding: .utf8) else { return }

            do {
                guard let doc = try? SwiftSoup.parse(html) else { return }
                let body = doc.body()
                let srcs = try body?.select("[class=views-field-field-ms-image-fid]").array()
                var imgsStringArray = [String]()

                try srcs?.forEach { img in
                    let elements = try img.getElementsByAttribute("src")
                    imgsStringArray.append(try elements.attr("src").description)
                }

                completion(imgsStringArray)
            } catch Exception.Error(let type, let message) {
                print("Type: \(type), Message: \(message)")
            } catch {
                print("error")
            }
        }
    }
}
