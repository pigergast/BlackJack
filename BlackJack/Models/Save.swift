/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: none
 */
import Foundation

//Game save struct for use when wanting to save game progress
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
