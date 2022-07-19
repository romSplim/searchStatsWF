//
//  FavoriteTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 12.03.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var clanLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var disclosureImg: UIImageView!
    let disclosure = UIImage(named: "disclosure")?.withTintColor(.myColor2, renderingMode: .alwaysOriginal)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disclosureImg.image = disclosure
        nickLabel.font = .mediumFont(size: 16)
        nickLabel.textColor = .white
        clanLabel.font = .regularFont(size: 16)
        clanLabel.textColor = .myColor2
        backgroundColor = .black
    }
    
    func setupCell(with player: FavoriteObject?, images: [Int: String]?) {
        guard let player = player,
              let images = images,
              let key = player.value(forKeyPath: "rankImage") as? Int else { return }
        let rank = images[key]
        
        nickLabel.text = player.nickName
        clanLabel.text = player.clanName
        rankImage.image = UIImage(named: rank ?? "")
    }
}
