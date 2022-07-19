//
//  UIFont.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 18.05.2022.
//

import UIKit

extension UIFont {
    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "LabGrotesque-Regular", size: size)!
    }
    
    class func mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "LabGrotesque-Medium", size: size)!
    }
    
    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "LabGrotesque-Bold", size: size)!
    }
}

