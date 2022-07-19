//
//  String+Extension.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 13.02.2022.


import UIKit

extension String{
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl: String {
        return self.removingPercentEncoding!
    }
}
