//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        hand?.map { $0.value }.contains(card.value) ?? false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        table.contains { key, value in
            hand?.map{ $0.value }.contains(key.value) ?? false || hand?.map{ $0.value }.contains(value.value) ?? false
        }
    }
}
