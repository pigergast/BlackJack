//
//  Card.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 09/08/2022.
//

import Foundation
import SwiftUI

enum Suits: String, CaseIterable, Codable{
    case SPADE
    case HEART
    case DIAMOND
    case CLUB
}

enum Ranks: String, CaseIterable, Codable{
    case TWO
    case THREE
    case FOUR
    case FIVE
    case SIX
    case SEVEN
    case EIGHT
    case NINE
    case TEN
    case JACK
    case QUEEN
    case KING
    case ACE
}

struct card: Equatable, Hashable, Codable{
    var suit: Suits
    var rank: Ranks
    var imageName: String {
        String(describing: self.suit) + String(describing: self.rank)
    }
    var image: Image{
        Image(imageName)
    }
    
}


let standardDeck = generateDeck()
let cardTest = card.init(suit: Suits.HEART, rank: Ranks.ACE)

var cardBack = card.init(suit: Suits.HEART, rank: Ranks.ACE)
