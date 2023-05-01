//
//  AchivesTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 19.06.2022.
//

import UIKit

class AchivesCell: UITableViewCell {
    var id = ""
    @IBOutlet weak var achieveImg: UIImageView!
    @IBOutlet weak var achieveLabel: UILabel!
    @IBOutlet weak var numberProgress: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        achieveImg.image = nil
    }
    
    
    
}
