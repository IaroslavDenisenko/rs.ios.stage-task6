import XCTest
@testable import ios_stage_task

final class GameTest: XCTestCase {
    var players: [Player] = []
    var game: Game = Game(players: [])
    var deck: Deck = Deck(with: .deck36)

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstAttackPlayerEmptyPlayers() throws {
        XCTAssertNil(game.defineFirstAttackingPlayer(players: players))
        
    }

    func testFirstAttackPlayerIncorectHandSize() throws {
        let player = Player()
        player.hand = [Card(suit: .clubs, value: .six), Card(suit: .diamonds, value: .seven), Card(suit: .hearts, value: .eight)]
        XCTAssertNil(game.defineFirstAttackingPlayer(players: [player]))
    }
    
    func testFirstAttackPlayerHappyPath() throws {
        let playerCount = Int.random(in: 2...5)
        for _ in 0..<playerCount {
            let player = Player()
            player.hand = []
            players.append(player)
        }
        deck.shuffle()
        let lesserTrump = Card(suit: .clubs, value: .six, isTrump: true) // Six Clubs
        deck.setTrumpCards(for: .clubs)
        deck.cards.remove(at: deck.cards.firstIndex(of: lesserTrump)!)
        deck.initialCardsDealForPlayers(players: players)
        let firstAttacker = players[Int.random(in: 0..<players.count)]
        firstAttacker.hand![Int.random(in: 0..<6)] = lesserTrump
        let result = game.defineFirstAttackingPlayer(players: players)
        XCTAssertEqual(result?.hand!, firstAttacker.hand!)
    }
}
