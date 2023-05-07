//
//  ClanNameCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 27.06.2022.
//

import UIKit

final class ClanNameCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var clanName: UILabel!
    @IBOutlet weak var countOfMembers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func configure(with clan: Clan?) {
        guard let clan else { return }
        let membersCount = clan.members.count
        clanName.text = clan.name
        countOfMembers.text = "Участников \(membersCount)/50"
    }
    
    private func setupLayout() {
        containerView.layer.cornerRadius = containerView.frame.height / 4
        clanName.font = .mediumFont(size: 24)
        countOfMembers.font = .regularFont(size: 17)
        countOfMembers.textColor = .myColor2
        clanName.sizeToFit()
        countOfMembers.sizeToFit()
    }
}
