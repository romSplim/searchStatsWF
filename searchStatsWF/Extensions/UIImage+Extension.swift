//
//  UIImage+Extension.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 25.05.2022.
//

import UIKit

extension UIImage {
    class var emptyStar: UIImage {
        return UIImage(named: "emptyStar")!.withTintColor(.myColor2)
    }
    
    class var fillStar: UIImage {
        return UIImage(named: "filledStar")!.withTintColor(.myColor2)
    }
}
