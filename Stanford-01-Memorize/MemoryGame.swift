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
    
    init(numberOfPairsOfCards: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        // Create an empty array of cards
        cards = []
        
        // Randomly select emojis from the Theme and add them to a set to prevent duplication.
        var cardIndices: Set<Int> = []
        while cardIndices.count < numberOfPairsOfCards {
            cardIndices.insert(Int.random(in: 0 ..< theme.emojis.count))
        }
        
        // Adding maching pairs according to the given number in the initialization, iterating through a card content array.
        // Making sure that at least 2 pairs of cards exist, even if the ViewModel calls the game with only 1 pair.
        for pairIndex in cardIndices {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    private(set) var score: Int = 0
    
    mutating func updateScore(_ offset: Int) {
        score += offset
        print("\(score - offset) + \(offset) = \(score)")
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // A variable to determine when to verify the matching state.
    var indexOfTheOneAndOnlyCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        
        // When a value is set to indexOfTheOneAndOnlyCard,
        // iterate through the cards array and update the isFaceUp status.
        // This setter doesn't run unless the value of indexOfTheOneAndOnlyCard gets changed.
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        // Finding the index of the chosen card by comparing its id, then flipping it over.
        // { cardToCheck in cardToCheck.id == card.id } -> { $0.id == card.id }
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                // If the indexOfTheOneAndOnlyCard is holding a value and not nill,
                // now is the second flip therefore run the verification.
                if let previouslyChosenIndex = indexOfTheOneAndOnlyCard {
                    // If the card contents match
                    if cards[chosenIndex].content == cards[previouslyChosenIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[previouslyChosenIndex].isMatched = true
                        updateScore(2)
                    } else {
                        if cards[chosenIndex].isAlreadySeen == false && cards[previouslyChosenIndex].isAlreadySeen == false {
                            cards[chosenIndex].isAlreadySeen = true
                            cards[previouslyChosenIndex].isAlreadySeen = true
                        } else if cards[chosenIndex].isAlreadySeen == true && cards[previouslyChosenIndex].isAlreadySeen == true {
                            updateScore(-2)
                        } else if cards[chosenIndex].isAlreadySeen == true || cards[previouslyChosenIndex].isAlreadySeen == true {
                            updateScore(-1)
                        }
                    }
                } else {
                    // If not, it is the first flip. Therefore update the indexOfTheOneAndOnlyCard, preparing for the second flip.
                    indexOfTheOneAndOnlyCard = chosenIndex
                }
                // Switch the isFaceUp status of the chosen card.
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // Apply Equatable protocol so the view can apply an animation based on its change.
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // Defining what it means that the card is equal to another, to conform to the Equtable protocol
        static func == (lhs: Card, rhs: Card) -> Bool {
            lhs.isFaceUp == rhs.isFaceUp
            && lhs.isMatched == rhs.isMatched
            && lhs.content == rhs.content
        }
        
        var isFaceUp = false
        var isMatched = false
        var isAlreadySeen = false
        let content: CardContent // The type to be decided when it's called.
        
        var id: String
        var debugDescription: String { "\(isMatched ? "_" : "\(id): \(content) \(isFaceUp ? "up" : "down")") \(isAlreadySeen ? "seen" : "")" }
    }
}

struct Theme {
    var name: String
    var numberOfPairsOfCards: Int
    var emojis: [String]
    var color: String
}

struct Themes {
    static var themeList: [Theme] = [
        Theme(name: "Flowers", numberOfPairsOfCards: 6, emojis: ["🌹", "🌸", "🌺", "🌻", "🪷", "🪻"], color: "pink"),
        Theme(name: "Animals", numberOfPairsOfCards: 6, emojis: ["🐶", "🐱", "🐯", "🐴", "🐻", "🐸"], color: "green"),
        Theme(name: "Fruits", numberOfPairsOfCards: 6, emojis: ["🍎", "🍌", "🍉", "🍇", "🍒", "🥭"], color: "yellow"),
        Theme(name: "Weather", numberOfPairsOfCards: 6, emojis: ["☀️", "🌧", "⛄️", "🌪", "🌈", "☁️"], color: "blue"),
        Theme(name: "Sports", numberOfPairsOfCards: 6, emojis: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🏓"], color: "orange"),
        Theme(name: "Vehicles", numberOfPairsOfCards: 6, emojis: ["🚗", "🚕", "🚙", "🚑", "🚜", "🚲"], color: "gray")
    ]
    
    static func getTheme() -> Theme {
        return themeList.randomElement()!
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
