//
//  DetailTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 01.03.2022.
//

import UIKit

protocol DetailCellProtocol: AnyObject {
    func didTapFavBtn(_ sender: UIButton)
    func didTapAchievesBtn(_ sender: UIButton)
    func didTapProgressBtn(_ sender: UIButton)
}

class DetailCell: UITableViewCell {
    
    weak var delegate: DetailCellProtocol?
    
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var clanLabel: UILabel!
    @IBOutlet weak var nextRankImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var achievesBtn: AnimatingButton!
    @IBOutlet weak var progressInfoBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        addTargets()
    }
    
    private func addTargets() {
        favoriteButton.addTarget(self, action: #selector(favButtonTapped) , for: .touchUpInside)
        achievesBtn.addTarget(self, action: #selector(achievesButtonTapped), for: .touchUpInside)
        progressInfoBtn.addTarget(self, action: #selector(progressButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        gradientLayer.frame = achievesBtn.bounds
        backgroundColor = .black
        nicknameLabel.textColor = .white
        nicknameLabel.font = .mediumFont(size: 17)
        clanLabel.font = .regularFont(size: 15)
        clanLabel.textColor = .myLightGray
//        expLabel.font = .regularFont(size: 14)
        favoriteButton.setImage(.emptyStar, for: .normal)
        achievesBtn.setTitle("Достижения", for: .normal)
        progressInfoBtn.setTitle("Прогресс", for: .normal)
//        achievesBtn.backgroundColor = .flatOrange
//        achievesBtn.tintColor = .amethyst
        achievesBtn.layer.cornerRadius = achievesBtn.frame.height / 2
        achievesBtn.layer.addSublayer(gradientLayer)
        clanLabel.textColor = gradientColor(bounds: clanLabel.bounds, gradientLayer: gradientLayer)
    }
    
    func setupCell(with player: Player?, images: [Int: String]) {
        if let key = player?.rankID {
            let rank = images[key]
            let nextRank = images[key + 1]
//            let progress = PlayerProgress.calculate(model: player, ranksStorage: StorageManager.ranksExp)
            nicknameLabel.text = player?.nickname
            clanLabel.text = clanStatus(model: player!)
            rankImage.image = UIImage(named: rank ?? images[100]!)
            nextRankImage.image = UIImage(named: nextRank ?? "")
            
        }
    }
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let blue = UIColor.blue.cgColor
        let orange = UIColor.orange.cgColor
        layer.colors = [blue, orange]
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return layer
    }()
    
    func gradientColor(bounds: CGRect, gradientLayer: CAGradientLayer) -> UIColor? {
    //We are creating UIImage to get gradient color.
          UIGraphicsBeginImageContext(gradientLayer.bounds.size)
          gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return UIColor(patternImage: image!)
    }
    

    
    func clanStatus(model: Player) -> String {
        return model.clanName ?? "Не состоит в клане"
    }
    

    @objc func favButtonTapped(_ sender: UIButton) {
        self.delegate?.didTapFavBtn(sender)
    }
    
    @objc func achievesButtonTapped(_ sender: UIButton) {
        self.delegate?.didTapAchievesBtn(sender)
    }
    
    @objc func progressButtonTapped(_ sender: UIButton) {
        self.delegate?.didTapProgressBtn(sender)
    }

}
