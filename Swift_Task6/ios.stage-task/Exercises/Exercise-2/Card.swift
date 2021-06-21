import Foundation

protocol CardBaseCompatible: Hashable, Codable {
    var suit: Suit {get}
    var value: Value {get}
    var isTrump: Bool {get}

    func hash(into hasher: inout Hasher)
}

enum Suit: Int, CaseIterable, Codable {
    case clubs
    case spades
    case hearts
    case diamonds
}

enum Value: Int, CaseIterable, Codable, Comparable {
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct Card: CardBaseCompatible {
    let suit: Suit
    let value: Value
    var isTrump: Bool = false

    func hash(into hasher: inout Hasher) {

    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.suit == rhs.suit && lhs.value == rhs.value
    }
}

extension Card {
    
    func checkIfCanBeat(card: Card) -> Bool {
        if self.isTrump && card.isTrump {
            return checkValue(card: card)
        }
        if self.isTrump && !card.isTrump {
            return true
        }
        if !self.isTrump && !card.isTrump {
            return checkValue(card: card)
        }
        return false
    }
    
    func checkValue(card: Card) -> Bool {
        return self.value > card.value
    }
}
