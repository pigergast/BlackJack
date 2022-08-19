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
    @State var playerMoney : Int = 100
    @State private var highscore = UserDefaults.standard.integer(forKey: "highscore")
    @State var Bet10 = true
    @State var Bet20 = false
    @State var gameInProgress = false
    @State var doubleDown = false
    
    func gameBegin(){
        gameDeck.newDeck()
        dealerHand.removeAll()
        playerHand.removeAll()
        for _ in 1...2{
            playerHand.append(gameDeck.drawCard())
            dealerHand.append(gameDeck.drawCard())
        }
    }
    
    func hit() {
        playerHand.append(gameDeck.drawCard())
    }
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    HStack{
                        Text("Money")
                            .font(.system(size: 22, weight: .medium))
                            .multilineTextAlignment(.leading)
                        Text("\(playerMoney)")
                            .font(.system(size: 22, weight: .medium))
                    }
                    .modifier(CapsuleModifier())
                    
                    
                    Spacer()
                    HStack{
                        Text("High Score")
                            .font(.system(size: 22, weight: .medium))
                            .multilineTextAlignment(.leading)
                        Text("\(highscore)")
                            .font(.system(size: 22, weight: .medium))
                    }
                    .modifier(CapsuleModifier()
                    )
                }
                Spacer()
                ZStack{
                    CardDeck().offset(x: -130)
                    VStack{
                        Spacer()
                        if(gameInProgress){
                            HStack{
                            ForEach(dealerHand, id: \.self) { card in
                                card.image.resizable().modifier(CardModifier())
                            }
                        }
                        }
                        Spacer()
                        if(gameInProgress){
                            HStack{
                            ForEach(playerHand, id: \.self) { card in
                                card.image.resizable().modifier(CardModifier())
                            }
                        }
                        }
                        Spacer()
                    }
                }
                HStack{
                    Button {
                    } label: {
                        Text("Bet 10")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(width: 80, height: 30)
                            )
                    }
                    Spacer()
                    Button {
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
            if(!gameInProgress){
                Button {
                    gameInProgress = true
                    gameBegin()
                } label: {
                    Text("Start")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.black)
                        .background(
                            Capsule().frame(width: 150, height: 100).foregroundColor(.yellow)
                        )
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
