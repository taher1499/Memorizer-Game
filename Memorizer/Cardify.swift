//
//  Cardify.swift
//  Memorizer
//
//  Created by Taher Poonawala on 25/06/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0:180
        self.isMatched = isMatched
    }
    var isMatched: Bool
    var rotation: Double // in degrees
    var animatableData: Double {
        get {
            rotation
        }
        set {
            rotation = newValue
        }
    }
    
    // if we want the card's to get flipped we have to animate rotation, unless we animate that the card flipping will still have the fading in/ fading out thing only because the rotation is either 0 or 180 it does gradually change unless we animate it
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if rotation < 90 {
                shape.stroke(lineWidth: 5)
                shape.foregroundColor(.white)
            }
            else if isMatched{
                shape.opacity(0)
            }
            else{shape.fill()}
            content
                .opacity(rotation < 90 ? 1:0)
                .font(.largeTitle)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
        
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
