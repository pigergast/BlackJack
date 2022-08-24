//
//  MenuView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import SwiftUI

struct MenuView: View {
    @State var highScoreList = (UserDefaults.standard.object(forKey: "highScoreList") as? [Double] ?? [])
    @State var roundsWon : Int = UserDefaults.standard.integer(forKey: "roundsWon")
    @State var roundsLost : Int = UserDefaults.standard.integer(forKey: "roundsLost")
    @Binding var gameSave: continueGame  //(UserDefaults.standard.object(forKey: "gameSave") as? continueGame ?? continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false))

    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color("CasinoGreen"), Color("LightGreen")]), center: .center, startRadius: 300, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/).ignoresSafeArea(.all)
                VStack {
                    if(gameSave.continueTrue){
                        NavigationLink(destination: GameView(roundsWon: $roundsWon, roundsLost: $roundsLost, highscore: $highScoreList, progressSave: $gameSave).onAppear{playSound2(sound: "background-jazz", type: "mp3"); gameSave.showIntro = false
                        }) { Capsule().foregroundColor(Color("CrimsonRed")).modifier(ContinueModifier())}
                    }
                    NavigationLink(destination: GameView(roundsWon: $roundsWon, roundsLost: $roundsLost, highscore: $highScoreList, progressSave: $gameSave).onAppear{playSound2(sound: "background-jazz", type: "mp3")
                        gameSave = continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false)
                    }) { Capsule().foregroundColor(Color("CrimsonRed")).modifier(PlayModifier())}
                    NavigationLink(destination: LeaderboardView(highScore: $highScoreList, roundsWon: $roundsWon, roundsLost: $roundsLost).onAppear{
                        playSound2(sound: "leaderboard", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(LeaderboardModifier())}
                    NavigationLink(destination: TutorialView().onAppear{
                        playSound2(sound: "tutorial", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(TutorialModifier())}
                }
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(gameSave: .constant(continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false)))
    }
}
