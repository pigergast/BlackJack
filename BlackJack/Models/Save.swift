//
//  Save.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 25/08/2022.
//

import Foundation
struct continueGame : Codable{
    var gameDeck : Deck
    var dealerHand :[card]
    var playerHand : [card]
    var showIntro: Bool
    var playerMoney : Double
    var betAmount: Double
    var gameLoss : Bool
    var gameWin : Bool
    var roundBust : Bool
    var roundWin : Bool
    var doubleDown : Bool
    var doubleAvailable : Bool
    var continueTrue: Bool
}
