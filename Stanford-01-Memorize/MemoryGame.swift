//
//  MemoryGame.swift
//  Stanford-01-Memorize
//
//  Created by 서희재 on 1/14/25.
//

import Foundation

// The Model that contains information of all components that compose the game.
struct MemoryGame<CardContent> {
    private(set) var cards: [Card] // Allowing external reading only by keeping the set private
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create an empty array of cards
        cards = []
        // Adding maching pairs according to the given number in the initialization, iterating through a card content array.
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func choose(_ card: Card) {
        // To be filled
    }
        
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent // The type to be decided when it's called.
    }
}
