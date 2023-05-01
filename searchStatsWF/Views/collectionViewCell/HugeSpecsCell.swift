//
//  HugeSpecsCollectionViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 30.04.2022.
//

import UIKit

class HugeSpecsCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
        myView.backgroundColor = .myBackgroundGray
        valueLabel.font = .boldFont(size: 16)
        valueLabel.textColor = .white
        textLabel.font = .regularFont(size: 14)
        textLabel.textColor = .myLightGray
        textLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        myView.layer.cornerRadius = myView.frame.height / 2.5
    }
    
    func setupCell(model: Player?, indexPath: IndexPath) {
        guard let model = model else { return }
        let staticValues = ["Матчей", "У/С", "Время за игрой", "Ранг", "Опыт"]
        let onlineTime = "\(String(describing: model.playtimeH.formattedWithSeparator))ч. \(String(describing: model.playtimeM))м."
        var killdeath: Double {
            let divideResult = (Double(model.kills) / Double(model.death))
            return round(divideResult * 1000) / 1000.0
        }
        let dynamicValues = [model.pvpAll, killdeath, onlineTime, model.rankID, model.experience] as [Any]
        textLabel.text = staticValues[indexPath.row]
        valueLabel.text = "\(dynamicValues[indexPath.row])"
    }
    
    private func setupLayer() {
        let layer = CAGradientLayer()
        let blue = UIColor.blue.cgColor
        let orange = UIColor.orange.cgColor
        layer.colors = [blue, orange]
        layer.locations = [0.0, 1.0]
        myView.layer.addSublayer(layer)
        
    }
    
}
