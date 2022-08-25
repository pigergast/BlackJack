/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: None
 */

import Foundation


//Deck struct for use in game logic. Used like a Stack
struct Deck: Codable {
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

