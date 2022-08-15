//
//  Deck.swift
//  BlackJack
//
//  Created by Oggy on 14/08/2022.
//

import Foundation

struct Deck {
    var cards : [card]
    
    init() {
        cards = generateDeck().shuffled()
    }
    mutating func drawCard() -> card {
        return cards.removeLast()
    }
    mutating func newDeck() {
        cards = generateDeck().shuffled()
    }
}

var gameDeck = Deck()
