//
//  GameView.swift
//  BlackJack
//
//  Created by Oggy on 16/08/2022.
//

import SwiftUI

struct GameView: View {
    @State var gameDeck = Deck()
    @State var dealerHand :[card] = []
    @State var playerHand :[card] = []
    @State var playerMoney : Double = 100
    @State private var highscore = UserDefaults.standard.double(forKey: "highscore")
    @State var betAmount: Double = 10
    @State var showIntro = true
    @State var gameInProgress = true
    @State var gameLoss = false
    @State var gameWin = false
    @State var roundBust = false
    @State var roundWin = false
    @State var doubleDown = false
    
    func lose(){
        roundBust = true
        if (doubleDown == true){
            playerMoney -= (betAmount * 2)
        }
        else{
            playerMoney -= betAmount
        }
    }
    
    
    func handWin() {
        roundWin = true
        if (doubleDown == true){
            if(handValue(hand: playerHand) != 21)
            {
                playerMoney += (betAmount * 2)
            }
            else {
                playerMoney += (betAmount * 2 * 1.5)
            }
        }
        else {
            if(handValue(hand: playerHand) != 21)
            {
                playerMoney += betAmount
            }
            else {
                playerMoney += betAmount * 1.5
            }
        }
    }
    
    func checkPlayerStatus() {
        if (handValue(hand: playerHand) > 21){
            lose()
        }
    }
    func dealerAction() {
        if(!roundBust && !roundWin)
        {
            while(handValue(hand: dealerHand) < 17){
                dealerHand.append(gameDeck.drawCard())
            }
            if(handValue(hand: dealerHand) > 21)
            {
                if(handValue(hand: playerHand) > 21)
                {
                    lose()
                    return
                }
                else {
                    handWin()
                    return
                }
            }
            if (handValue(hand: playerHand) > handValue(hand: dealerHand))
            {
                handWin()
                return
            }
            else{
                lose()
                return
            }
        }
    }
    
    
    
    func gameBegin(){
        gameDeck.newDeck()
        dealerHand.removeAll()
        playerHand.removeAll()
        roundWin = false
        roundBust = false
        doubleDown = false
        for _ in 1...2{
            playerHand.append(gameDeck.drawCard())
            dealerHand.append(gameDeck.drawCard())
        }
    }
    
    func hit() {
        if(!roundBust && !roundWin && !doubleDown)
        {
            playerHand.append(gameDeck.drawCard())
            checkPlayerStatus()
        }
    }
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    playerScore
                    
                    Spacer()
                    
                    highScore
                }.frame(width: UIScreen.main.bounds.width, height: 120)
                Spacer()
                ZStack{
                    HStack {
                        CardDeck()
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        HStack{
                            if(gameInProgress){
                                HStack{
                                    ForEach(dealerHand, id: \.self) { card in
                                        card.image.resizable().modifier(CardModifier())
                                    }
                                }
                            }
                        }.frame(height: 100)
                        Spacer()
                            .frame(height:130)
                        HStack{
                            if(gameInProgress){
                                HStack{
                                    ForEach(playerHand, id: \.self) { card in
                                        card.image.resizable().modifier(CardModifier())
                                    }
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width - 20, height: 100)
                        Spacer()
                    }
                }
                HStack{
                    Button {
                        betAmount = 10
                    } label: {
                        Text("Bet 10")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(width: 80, height: 30)
                            )
                    }
                    Spacer()
                    if(roundBust || roundWin) {
                        Button {
                            gameBegin()
                        } label: {
                            Text("Next round")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.black)
                                .background(
                                    Capsule().frame(width: 150, height: 30)
                                )
                        }
                    }
                    Spacer()
                    Button {
                        betAmount = 20
                    } label: {
                        Text("Bet 20")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(width: 80, height: 30)
                            )
                    }
                }.padding(.horizontal, 10)
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        hit()
                    } label: {
                        Text("Hit")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(minWidth: 50, idealWidth: 70, maxWidth: 100, minHeight: 35)
                            )
                    }
                    Spacer()
                    Button {
                        hit()
                        doubleDown = true
                    } label: {
                        Text("Double")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(minWidth: 100, minHeight: 35)
                            )
                    }
                    Spacer()
                    Button {
                        dealerAction()
                    } label: {
                        Text("Stand")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(minWidth: 100, minHeight: 35)
                            )
                    }
                    Spacer()
                }
            }
            Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()
                .opacity(showIntro ? 1 : 0)
            if(showIntro){
                Button {
                    gameInProgress = true
                    showIntro = false
                    gameBegin()
                    
                    
                } label: {
                    Capsule().frame(width: 150, height: 100).foregroundColor(.yellow)
                        .overlay {
                            Text("Start")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.black)
                        }
                }
            }
        }
    }
}

extension GameView{
    var playerScore : some View{
        HStack{
            Text("💵")
                .font(.system(size: 22, weight: .medium))
                .multilineTextAlignment(.leading)
            Text("\(Int(playerMoney))")
                .font(.system(size: 22, weight: .medium))
        }
        .modifier(CapsuleModifier())
    }
    var highScore : some View {
        HStack{
            Text("High Score")
                .font(.system(size: 22, weight: .medium))
                .multilineTextAlignment(.leading)
            Text("\(Int(highscore))")
                .font(.system(size: 22, weight: .medium))
        }
        .modifier(CapsuleModifier()
        )
    }
}




struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
