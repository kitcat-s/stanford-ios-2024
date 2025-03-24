//
//  Themes.swift
//  Stanford-01-Memorize
//
//  Created by Kitcat Seo on 2/26/25.
//

import Foundation

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
