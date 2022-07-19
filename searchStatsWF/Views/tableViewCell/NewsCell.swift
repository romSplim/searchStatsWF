//
//  NewsTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 16.03.2022.
//

import UIKit
import AlamofireRSSParser
import SkeletonView

class NewsCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
   
    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupCell(item: RSSItem) {
        titleLabel.text = item.title
        subTitleLabel.text = item.itemDescription?.replacingOccurrences(of: "&quot;", with: "'")
        
    }
    
    private func setupViews() {
        setupSkeleton()
        self.selectionStyle = .none
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cellView.layer.shadowRadius = CGFloat(8)
        cellView.backgroundColor = .secondarySystemGroupedBackground
        cellView.clipsToBounds = true
        cellView.backgroundColor = .black
        cellView.layer.borderWidth = 0.3
        cellView.layer.borderColor = UIColor.myLightGray.cgColor
        newsImage.contentMode = .scaleAspectFill
        titleLabel.font = .mediumFont(size: 20)
        titleLabel.textColor = .white
        subTitleLabel.font = .regularFont(size: 14)
        subTitleLabel.textColor = .myColor2
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
        contentView.backgroundColor = .black
        
    }
    
    private func setupSkeleton() {
        titleLabel.skeletonTextNumberOfLines = 1
        subTitleLabel.skeletonTextNumberOfLines = 2
        titleLabel.skeletonTextLineHeight = .relativeToFont
        subTitleLabel.skeletonTextLineHeight = .relativeToFont
        titleLabel.linesCornerRadius = 10
        subTitleLabel.linesCornerRadius = 10
    }

}
