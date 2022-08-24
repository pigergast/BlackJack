//
//  GameFunctions.swift
//  BlackJack
//
//  Created by Oggy on 15/08/2022.
//

import Foundation

func generateDeck() -> [card]{
    var cards =  [card]()
    for suit in Suits.allCases{
        for rank in Ranks.allCases{
            cards.append(card.init(suit: suit, rank: rank))
        }
    }
    return cards
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
func handValue(hand: [card]) -> Int{
    var value: Int = 0
    var aceNum : Int = 0
    for card in hand
    {
        if (card.rank == Ranks.ACE){
            aceNum += 1
        }
        value += cardValue(c: card)
    }
    
    while(aceNum > 0) {
        if value > 21{
            value -= 10
            aceNum -= 1
        }
        else{
            break
        }
    }
    return value;
    
}
