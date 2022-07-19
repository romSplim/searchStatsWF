//
//  SpecsTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 01.03.2022.
//

import UIKit

class SpecsCell: UITableViewCell {
    @IBOutlet weak var specsStaticLabel: UILabel!
    @IBOutlet weak var specsDynamicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFont()
    }
    
    private func setupFont() {
        backgroundColor = .black
        specsStaticLabel.textColor = .myColor
        specsDynamicLabel.textColor = .white
        specsStaticLabel.font = .regularFont(size: 16)
        specsDynamicLabel.font = .mediumFont(size: 16)
    }
    
    func setupCell(with model: Player?, indexPath: IndexPath) {
        guard let model = model else { return }
        if indexPath.section == 2 {
            let staticSpecs = [ "Убийства", "Убито своих", "Смерти", "Победы", "Поражения", "Всего матчей", "Соотношения", "Любимый класс" ]
            let dynamicSpecs: [Any?] = [model.kill.formattedWithSeparator, model.friendlyKills.formattedWithSeparator, model.death.formattedWithSeparator, model.pvpWINS.formattedWithSeparator, model.pvpLost.formattedWithSeparator, model.pvpAll.formattedWithSeparator, model.pvpwl, model.favoritPVP]
            
            specsStaticLabel.text = staticSpecs[indexPath.row]
            specsDynamicLabel.text = "\(dynamicSpecs[indexPath.row] ?? "")"
        } else {
            let staticSpecs = ["Убийства","Убито своих","Смерти","Убийства/Смерти","Победы","Поражения","Всего миссий"]
            let dynamicSpecs: [Any?] = [model.pveKill.formattedWithSeparator, model.pveFriendlyKills.formattedWithSeparator, model.pveDeath.formattedWithSeparator, model.pve, model.pveWINS.formattedWithSeparator, model.pveLost.formattedWithSeparator, model.pveAll.formattedWithSeparator]
            specsStaticLabel.text = staticSpecs[indexPath.row]
            specsDynamicLabel.text = "\(dynamicSpecs[indexPath.row] ?? "")"
        }
    }
}
