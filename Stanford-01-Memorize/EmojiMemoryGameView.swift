//
//  EmojiMemoryGameView.swift
//  Stanford-01-Memorize
//
//  Created by Heejae Seo on 5/2/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            .padding(12)
            Button("Suffle") {
                viewModel.shuffle()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(3/4, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 5)
            
            Group {
                base.stroke(style: StrokeStyle(lineWidth: 2))
                base.fill(.white)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            base.stroke(style: StrokeStyle(lineWidth: 2))
        }
    }
}







#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}



/*
 To-do list
 1.
 
 Today's Keyword
 -
 
 Today's Lesson
 - Struct in functional programming VS class in object-oriented programming
 - Array types: String, Int...
 */
