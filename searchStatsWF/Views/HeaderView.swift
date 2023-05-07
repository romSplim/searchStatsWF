//
//  HeaderView.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 23.05.2022.
//

import UIKit

protocol HeaderViewDataSource: AnyObject {
    func numberOfTrackingPlayers(_ inView: UIView) -> Int
}

class HeaderView: UIView {
    var titleText: String
    var trackingNum: String?
    
    weak var dataSource: HeaderViewDataSource? {
        didSet {
            updateHeaderView()
        }
    }
    
    init(title: String) {
        self.titleText = title
        super.init(frame: .zero)
        setup()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHeaderView() {
        if let dataSource = dataSource?.numberOfTrackingPlayers(self) {
            headerTitle.text = titleText + " " + "\(dataSource)"
        }
    }
    
    func setup() {
        backgroundColor = .black
        addSubview(headerTitle)
        headerTitle.text = titleText + " " + (trackingNum ?? "")
    }
    
     var headerTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: 30))
        label.textAlignment = .left
        label.font = .boldFont(size: 20)
        label.textColor = .white
        return label
    }()
}
