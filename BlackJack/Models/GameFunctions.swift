/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: https://brilliant.org/wiki/programming-blackjack/ for basic game logic
 */

import Foundation

//Functions for use in game logic


//Generate a standard deck of 52 cards
func generateDeck() -> [card]{
    var cards =  [card]()
    for suit in Suits.allCases{
        for rank in Ranks.allCases{
            cards.append(card.init(suit: suit, rank: rank))
        }
    }
    return cards
}

//Get the value of a card based on their rank enum
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

//Get the value of a hand of cards
func handValue(hand: [card]) -> Int{
    var value: Int = 0
    var aceNum : Int = 0
    for card in hand
    {
        //Count aces
        if (card.rank == Ranks.ACE){
            aceNum += 1
        }
        value += cardValue(c: card)
    }
    //If the hand is bust but there is an ace, set ace as 1 to lower the hand value
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
