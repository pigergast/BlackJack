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
import SwiftUI

//Card struct for use in game logic and UI

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

