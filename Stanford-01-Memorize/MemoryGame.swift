//
//  MemoryGame.swift
//  Stanford-01-Memorize
//
//  Created by 서희재 on 1/14/25.
//

import Foundation

// The Model that contains information of all components that compose the game.
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] // Allowing external reading only by keeping the set private
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create an empty array of cards
        cards = []
        // Adding maching pairs according to the given number in the initialization, iterating through a card content array.
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) { // Making sure that at least 2 pairs of cards should exist, even if the ViewModel calls the game with only 1 pair.
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func choose(_ card: Card) {
        // To be filled
    }
    
    // Apply Equatable protocol so the view can apply an animation based on its change.
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // Defining what it means that the card is equal to another, to conform to the Equtable protocol
        static func == (lhs: Card, rhs: Card) -> Bool {
            lhs.isFaceUp == rhs.isFaceUp
            && lhs.isMatched == rhs.isMatched
            && lhs.content == rhs.content
        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent // The type to be decided when it's called.
        
        var id: String
        var debugDescription: String { "\(id)" }
    }
}
