/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: Userdefaults encoding and decoding from https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
 */

import SwiftUI

struct MenuView: View {
    
    //State variables to pass into navigated views
    
    //Remember difficulty player selects
    @State var easyMode = UserDefaults.standard.bool(forKey: "easyMode")
    
    @State var highScoreList = (UserDefaults.standard.object(forKey: "highScoreList") as? [Double] ?? [])
    @State var roundsWon : Int = UserDefaults.standard.integer(forKey: "roundsWon")
    @State var roundsLost : Int = UserDefaults.standard.integer(forKey: "roundsLost")
    @Binding var gameSave: continueGame  
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color("CasinoGreen"), Color("LightGreen")]), center: .center, startRadius: 300, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/).ignoresSafeArea(.all)
                VStack {
                    Image("Logo").resizable().scaledToFit()
                        .frame(height: 150)
                    Text("RMIT Blackjack").foregroundColor(.white).font(.largeTitle)
                    Spacer()
                    //If there is a valid save game, show continue button
                    if(gameSave.continueTrue){
                        NavigationLink(destination: GameView(easyMode: $easyMode, roundsWon: $roundsWon, roundsLost: $roundsLost, highscore: $highScoreList, progressSave: $gameSave).onAppear{playSound2(sound: "background-jazz", type: "mp3"); gameSave.showIntro = false
                        }) { Capsule().foregroundColor(Color("CrimsonRed")).modifier(ContinueModifier())}
                    }
                    //Button to start a fresh game
                    NavigationLink(destination: GameView(easyMode: $easyMode, roundsWon: $roundsWon, roundsLost: $roundsLost, highscore: $highScoreList, progressSave: $gameSave).onAppear{playSound2(sound: "background-jazz", type: "mp3")
                        gameSave = continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false)
                    }) { Capsule().foregroundColor(Color("CrimsonRed")).modifier(PlayModifier())}
                    //Button to navigate to difficulty setting view
                    NavigationLink(destination: DifficultySettingView(easyMode: $easyMode).onAppear{
                        playSound2(sound: "background-jazz", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(SettingModifier())}
                    //Button to navigate to leaderboard
                    NavigationLink(destination: LeaderboardView(highScore: $highScoreList, roundsWon: $roundsWon, roundsLost: $roundsLost).onAppear{
                        playSound2(sound: "leaderboard", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(LeaderboardModifier())}
                    //Button to navigate to tutorial
                    NavigationLink(destination: TutorialView().onAppear{
                        playSound2(sound: "tutorial", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(TutorialModifier())}
                    Spacer()
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
