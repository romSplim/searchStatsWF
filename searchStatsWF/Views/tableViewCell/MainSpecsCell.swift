//
//  MainSpecsTableViewCell.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 06.03.2022.
//

import UIKit

class MainSpecsCell: UITableViewCell {

    @IBOutlet weak var myCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        myCollectionView.register(UINib(nibName: "HugeSpecsCell", bundle: nil), forCellWithReuseIdentifier: "HugeSpecsCell")
        myCollectionView.showsHorizontalScrollIndicator = false
        contentView.backgroundColor = .black
        myCollectionView.backgroundColor = .black
    }
}
