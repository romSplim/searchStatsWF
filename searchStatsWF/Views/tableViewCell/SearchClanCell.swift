//
//  SearchClanTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 28.03.2022.
//

import UIKit

class SearchClanCell: UITableViewCell {

    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var rankImg: UIImageView!
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var clanRole: UILabel!
    @IBOutlet weak var clanPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    private func setupLayout() {
        clanRole.font = .regularFont(size: 15)
        clanRole.textColor = .myColor2
        nickNameLbl.font = .mediumFont(size: 16)
        nickNameLbl.textColor = .white
        clanPoints.sizeToFit()
        nickNameLbl.sizeToFit()
        numberLbl.sizeToFit()
    }
    func setupCell(model: Clan?, indexPath: IndexPath, ranks: [Int: String]) {
        guard let model = model else { return }
        let member = model.members[indexPath.row]
        let rank = model.members[indexPath.row].rankID
        let intRank = Int(rank)
        numberLbl.text = "\(indexPath.row + 1)"
        rankImg.image = UIImage(named: ranks[intRank!]!)
        nickNameLbl.text = member.nickname
        clanRole.text = member.clanRole.localize()
        clanPoints.text = member.clanPoints
    }
    
}
