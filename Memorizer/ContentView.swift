//
//  ContentView.swift
//  Memorizer
//
//  Created by Taher Poonawala on 31/05/21.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewmodel: EmojiMemoryGame
    @Namespace private var DealingCards
        
    var body: some View {
        ZStack(alignment: .bottom)
        {
        VStack{
                title
                gameView
            HStack{
            newgame
            Spacer()
            }
        }
            deckbody
        }
    }
    
    var title: some View {
        HStack{
            Spacer(minLength: 80)
            Text(viewmodel.name).fontWeight(.heavy)
            Spacer(minLength: 10)
            Text("Score: \(viewmodel.score)").fontWeight(.heavy)
        }.font(.title)
        .padding()
    }
    
    
    @State private var dealt = Set<Int>()

    private func deal(_ card: MemoryGame<String>.Card){
        dealt.insert(card.id)
    }

    private func isUndealt (_ card: MemoryGame<String>.Card) -> Bool{
        !dealt.contains(card.id)
    }

    var gameView: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))])
                { ForEach(viewmodel.cards) { card in
                if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                    Color.clear
                }
                else{
                    CardView(card: card )
                        .aspectRatio(2/3, contentMode: .fit)
                        .matchedGeometryEffect(id: card.id, in: DealingCards)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .onTapGesture {
                            withAnimation{
                                viewmodel.choose(card)
                            }
                        }
                }
            }
                }
            .foregroundColor(viewmodel.color)
            //.matchedGeometryEffect(id: 1, in: DealingCards)
            .padding()
            

            }
        
    }
    
    var deckbody: some View {
        ZStack{
            ForEach(viewmodel.cards.filter(isUndealt)) { card in
            CardView(card: card )
                .matchedGeometryEffect(id: card.id, in: DealingCards)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))

                }
        }
        .frame(width: 60, height: 90)
        .foregroundColor(viewmodel.color)
        .onTapGesture {
            withAnimation{
                for card in viewmodel.cards{
                    deal(card)
                }
            }
        }
    }
    
    var newgame: some View {
        Button("New Game")
        {
            withAnimation{
            dealt = []
            viewmodel.ChangeTheme()
            }
        }.padding()
    }
    
        
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View{
        Text(card.content).cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
    }
    
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewmodel : game)
    }
}
