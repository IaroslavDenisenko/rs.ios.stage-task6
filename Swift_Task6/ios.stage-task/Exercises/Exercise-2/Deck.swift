import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var cards = [Card]()
        for suit in Suit.allCases {
            for value in Value.allCases {
                let card = Card(suit: suit, value: value)
                cards.append(card)
            }
        }
        return cards
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        trump = cards.first?.suit
        guard let trumpSuit = trump else { return }
        setTrumpCards(for: trumpSuit)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players {
            player.hand = Array(cards.prefix(upTo: 6))
            cards.removeFirst(6)
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        var trumpedCards = [Card]()
        for card in cards {
            var trumpedCard = card
            if card.suit == suit {
                trumpedCard.isTrump = true
            }
            trumpedCards.append(trumpedCard)
        }
        cards = trumpedCards
    }
}

