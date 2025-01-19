//
//  EmojiMemoryGame.swift
//  Stanford-01-Memorize
//
//  Created by 서희재 on 1/14/25.
//

import SwiftUI

// The ViewModel that connects the Model to the View, holding information about the type of the game which is an emoji(string) type.
class EmojiMemoryGame: ObservableObject {
    // Added a "static" to the property to solve the issue of random order of initialization. This makes the property global within sustaining the namespace of the EmojiMemoryGame class.
    private static let emojis = ["1", "2", "3", "4", "5", "6", "7"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        // Create a game assigning the pair.
        return MemoryGame(numberOfPairsOfCards: 9) { pairIndex in // Providing the card contents as a closure type.
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉"
            }
        }
    }
    
    // Initialize a game as a variable.
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

/*
 To-do list
 [x] Write a function to create a model and initialize the model by assigning it as a 'model'
 
*/
