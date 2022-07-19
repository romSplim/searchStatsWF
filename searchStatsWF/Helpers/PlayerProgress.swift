//
//  CalculatePlayerProgress.swift
//  searchStatsWF
//
//  Created by Рамиль Ахатов on 21.06.2022.
//

import Foundation

class PlayerProgress {
    
    private lazy var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .percent
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    static func calculate(model: Player?, ranksStorage: [Int: Int]) -> Float {
        guard let model = model else { return 0 }
        let progress = model.rankID >= 100 ? setMaxProgress() : calculateExp(model: model, ranksStorage: ranksStorage)
        return progress
    }
    
    static private func setMaxProgress() -> Float {
        return 1
    }
    
    static private func calculateExp(model: Player, ranksStorage: [Int : Int]) -> Float {
        let currentRank = Float(ranksStorage[model.rankID]!)
        let nextRank = Float(ranksStorage[model.rankID + 1]!)
        
        let currentExp = Float(model.experience)
        let expBetweenRanks = nextRank - currentRank
        let progress = (currentExp - currentRank) / expBetweenRanks
        return progress
        
        
    }
}
