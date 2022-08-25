//
//  DataHelper.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 25/08/2022.
//

import Foundation

let decoder = JSONDecoder()
let encoder = JSONEncoder()
let defaultData = try! encoder.encode(continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false))
