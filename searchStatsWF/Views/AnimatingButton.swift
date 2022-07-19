//
//  AnimatingButton.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 28.06.2022.
//

import UIKit

class AnimatingButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            guard let color = backgroundColor else { return }

            UIView.animate(withDuration: self.isHighlighted ? 0 : 0.4, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.backgroundColor = color.withAlphaComponent(self.isHighlighted ? 0.3 : 1)
            })
        }
    }
}

