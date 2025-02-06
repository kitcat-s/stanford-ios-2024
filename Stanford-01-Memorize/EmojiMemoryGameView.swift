//
//  EmojiMemoryGameView.swift
//  Stanford-01-Memorize
//
//  Created by Heejae Seo on 5/2/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Observe the ViewModel to know when to redraw the View.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(spacing: 12) {
            HeaderView()
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .padding(.horizontal, 12)
        }
        .onAppear {
            viewModel.shuffle()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            // Iterating through the cards by their IDs, as marked within this view, prevents tracking the original and destination positions during shuffling.
            /*
             ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(3/4, contentMode: .fit)
                    .padding(4)
            }
             */
            
            // Iterating through the cards by their IDs from the ViewModel enables the card to have the flying animation rather than a boring fade in & out.
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(3/4, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.getColor())
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0.1)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Text("Theme Title")
                    .font(.largeTitle)
                Button {
                    print("New Game")
                } label: {
                    Spacer()
                    Image(systemName: "plus.app")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.black)
                        .frame(width: 24)
                        .padding(.trailing)
                }
            }
            ScoreView()
        }
    }
}

struct ScoreView: View {
    var body: some View {
        Text("Score")
            .font(.system(size: 18))
            .bold()
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
            })
            .foregroundStyle(.black)
    }
}





#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
