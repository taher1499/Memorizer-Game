//
//  MemoryGame.swift
//  Memorizer
//
//  Created by Taher Poonawala on 14/06/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private (set) var cards: Array<Card>
    
    private var IndexofCardthatisAlreadyFaceUp: Int? {
        get {cards.indices.filter({cards[$0].isFaceUp})
            .onenadOnly()}
        set {cards.indices.forEach {cards[$0].isFaceUp=($0==newValue)}}
    }
    
    private(set) var score: Int = 0
    
    mutating func choose(_ card: Card) {
        if let chosenindex=cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenindex].isFaceUp,
           !cards[chosenindex].isMatched
        {
            if let ObservedCardIndex = IndexofCardthatisAlreadyFaceUp {
                if cards[ObservedCardIndex].content == cards[chosenindex].content
                {
                    cards[ObservedCardIndex].isMatched = true
                    cards[chosenindex].isMatched = true
                    score+=2
                }
                else if cards[ObservedCardIndex].CardhasBeenSeen && cards[chosenindex].CardhasBeenSeen
                {
                    score-=2
                }

                else if cards[chosenindex].CardhasBeenSeen || cards[ObservedCardIndex].CardhasBeenSeen
                {
                    score-=1
                }
                cards[chosenindex].isFaceUp = true
            }
            else
            {
                cards.indices.filter({cards[$0].isFaceUp})
                    .forEach({cards[$0].CardhasBeenSeen=true})
                IndexofCardthatisAlreadyFaceUp=chosenindex
            }
        }
    }
    
    init(numberofPairsofCards: Int, CreateCardContent: (Int)->CardContent){
        cards=Array<Card>()
        for pairIndex in 0..<numberofPairsofCards{
            let content = CreateCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }
    
   
    
    struct Card: Identifiable {
        var isFaceUp = false
        var content: CardContent
        var isMatched = false
        var id: Int
        var CardhasBeenSeen: Bool = false

    }
    
}

enum Theme: CaseIterable {
    
    case Sports, Animals, Fruits
    
    struct Values {
        let NumberofPairs: Int
        let Emojis: Array<String>
        let name: String
        let color: String
    }
    
    var values: Values {
        switch self {
        case .Animals:
            return Values(NumberofPairs: 12, Emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐵","🐔","🐧","🐦","🐤","🦆","🦅","🦉","🦇","🐺","🐗","🐴","🦄","🐆","🦓","🦍","🦧","🦣","🐘","🦛","🦏","🐪"].shuffled(), name: "Animals", color: "Blue")
        case .Fruits:
            return Values(NumberofPairs: 12, Emojis: ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥬","🥒","🌶","🫑","🌽","🥕","🫒","🧄","🧅","🥔","🍠"].shuffled(), name: "Fruits", color: "Yellow")
        case .Sports:
            return Values(NumberofPairs: 12, Emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","🏑","🥍","🏏","🪃","🥅","⛳️","🪁","🏹","🎣","🤿","🥊","🥋","🎽","🛹","🛼","🛷","⛸","🥌","🎿"].shuffled(), name: "Sports", color: "Purple")
        }
    }
    
    
}

extension Array {
    func onenadOnly () -> Element? {
        if count == 1 {
            return first
        }
        else{
            
            return nil
        }

    }
}
