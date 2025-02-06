//
//  EmojiMemoryGame.swift
//  Stanford-01-Memorize
//
//  Created by 서희재 on 1/14/25.
//

import SwiftUI

var randomTheme = Themes.getTheme()

// The ViewModel that connects the Model to the View, holding information about the type of the game which is an emoji(string) type.
class EmojiMemoryGame: ObservableObject {
    // Added a "static" to the property to solve the issue of random order of initialization. This makes the property global within sustaining the namespace of the EmojiMemoryGame class.
    private static func createMemoryGame() -> MemoryGame<String> {
        // Create a game specifying how many pairs of cards the game will have.
        return MemoryGame(numberOfPairsOfCards: randomTheme.emojis.count, theme: randomTheme) { pairIndex in // Providing the card contents as a closure type.
            // If the pairs are within the emojis array indices
            if randomTheme.emojis.indices.contains(pairIndex) {
                return randomTheme.emojis[pairIndex]
            } else {
                // If the game has more.
                return "⁉"
            }
        }
    }
    
    func getColor() -> Color {
        switch randomTheme.color {
        case "pink": .pink
        case "green": .green
        case "red": .red
        case "blue": .blue
        case "orange": .orange
        case "gray": .gray
        default: .black
        }
    }
    
    func getTitle() -> String {
        return randomTheme.name
    }
    
    // Initialize a game as a variable,
    // publishing it so the view will notice when it changes.
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func loadNewGame() {
        randomTheme = Themes.getTheme()
        model = EmojiMemoryGame.createMemoryGame()
        model.shuffle()
    }
}
