//
//  MemorizeApp.swift
//  Stanford-01-Memorize
//
//  Created by Heejae Seo on 5/2/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
