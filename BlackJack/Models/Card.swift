//
//  Card.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 09/08/2022.
//

import Foundation
import SwiftUI

enum Suits: String, CaseIterable{
    case SPADE
    case HEART
    case DIAMOND
    case CLUB
}

enum Ranks: String, CaseIterable{
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

struct card: Equatable{
    var suit: Suits
    var rank: Ranks
    var imageName: String {
        String(describing: self.suit) + String(describing: self.rank)
    }
    var image: Image{
        Image(imageName)
    }
    func cardValue(c: card) -> Int {
        switch c.rank{
        case .TWO:
            return 2
        case .THREE:
            return 3
        case .FOUR:
            return 4
        case .FIVE:
            return 5
        case .SIX:
            return 6
        case .SEVEN:
            return 7
        case .EIGHT:
            return 8
        case .NINE:
            return 9
        case .TEN:
            return 10
        case .JACK:
            return 10
        case .QUEEN:
            return 10
        case .KING:
            return 10
        case .ACE:
            return 11
        }
    }
}


func generateDeck() -> [card]{
    var cards =  [card]()
    for suit in Suits.allCases{
        for rank in Ranks.allCases{
            cards.append(card.init(suit: suit, rank: rank))
            print(String(describing: rank) + String(describing: suit))
        }
    }
    return cards
}
let standardDeck = generateDeck()
let cardTest = card.init(suit: Suits.HEART, rank: Ranks.ACE)
