//
//  MemorizerApp.swift
//  Memorizer
//
//  Created by Taher Poonawala on 31/05/21.
//

import SwiftUI

@main
struct MemorizerApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewmodel: game)
        }
    }
}
