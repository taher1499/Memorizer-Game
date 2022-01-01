//
//  EmojiMemoryGame.swift
//  Memorizer
//
//  Created by Taher Poonawala on 14/06/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    init() {
        
        self.theme = Theme.allCases.randomElement()!
        
        func CreateMemoryGame(_ theme: Theme.Values)->MemoryGame<String>
        {
            MemoryGame<String>(numberofPairsofCards: Int.random(in: 4..<min(theme.NumberofPairs,theme.Emojis.count)),
                               CreateCardContent: {pairIndex in theme.Emojis[pairIndex]})
        }
        
        self.model = CreateMemoryGame(self.theme.values)
        
        self.name = self.theme.values.name
        
        let colors: Dictionary<String,Color> = ["Orange":.orange,
                                                "Blue":.blue,
                                                "Yellow":.yellow,
                                                "Purple":.purple]
        
        self.color = colors[self.theme.values.color] ?? .red

    }

    @Published private var model: MemoryGame<String>
    
    private var theme: Theme
        
    private (set) var name: String
    
    private (set) var color: Color
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
   
    // MARK: Intent
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func ChangeTheme() {
        
        self.theme = Theme.allCases.randomElement()!
    
        
        func CreateMemoryGame(theme: Theme.Values)->MemoryGame<String>
        {
            MemoryGame<String>(numberofPairsofCards: Int.random(in: 4..<min(theme.Emojis.count,theme.NumberofPairs)),
                               CreateCardContent: {pairIndex in theme.Emojis[pairIndex]})
        }
        
        self.model = CreateMemoryGame(theme: self.theme.values)
        
        let colors: Dictionary<String,Color> = ["Orange":.orange,
                                                "Blue":.blue,
                                                "Yellow":.yellow,
                                                "Purple":.purple]
        
        self.color = colors[self.theme.values.color] ?? .red

        self.name = self.theme.values.name

    }
    
   
}


