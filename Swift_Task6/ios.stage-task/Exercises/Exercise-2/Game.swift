//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        guard players.count > 1 else { return nil }
        
        let trumpPlayers = players.filter { $0.hand!.contains { $0.isTrump } }
        
        if trumpPlayers.isEmpty { return players.first }
        if trumpPlayers.count == 1 { return trumpPlayers.first }
        
        return trumpPlayers.min { (player1, player2) -> Bool in
            let player1Card = player1.hand!.filter { $0.isTrump }
                .min { $0.value < $1.value }
            let player2Card = player2.hand!.filter { $0.isTrump }
                .min { $0.value < $1.value }
            return player1Card!.value < player2Card!.value
        }
    }
}
