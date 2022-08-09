//
//  Deck.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 09/08/2022.
//

import Foundation



func makeDeck() -> Stack<card>{
    var deck = Stack<card>()
    let cards = generateDeck().shuffled()
    for card in cards {
        deck.push(card)
    }
    return deck
}

var playingDeck = makeDeck();

