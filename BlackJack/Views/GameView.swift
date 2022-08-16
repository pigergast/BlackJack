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
    @State var bet = 10
    
    
    var body: some View {
        VStack{
            HStack {
                HStack{
                    Text("Money")
                        .font(.system(size: 22, weight: .medium))
                        .multilineTextAlignment(.leading)
                    Text("100")
                        .font(.system(size: 22, weight: .medium))
                }
                .modifier(CapsuleModifier())
                
                
                Spacer()
                HStack{
                    Text("High\nScore")
                        .font(.system(size: 22, weight: .medium))
                        .multilineTextAlignment(.leading)
                    Text("100")
                        .font(.system(size: 22, weight: .medium))
                }
                .modifier(CapsuleModifier()
                )
            }
            Spacer()
            
            HStack{
                Image("BACK").resizable()
                    .modifier(CardModifier())
                Image("BACK").resizable()
                    .modifier(CardModifier())
            }
            Spacer()
            HStack{
                Image("BACK").resizable()
                    .modifier(CardModifier())
                Image("BACK").resizable()
                    .modifier(CardModifier())
            }
            Spacer()
            
            HStack{
                Spacer()
                Button {
                } label: {
                    Text("Bet 10")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.black)
                        .background(
                            Capsule().frame(minWidth: 60, idealWidth: 80, maxWidth: 110, minHeight: 35)
                        )
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Button {
                } label: {
                    Text("Bet 20")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.black)
                        .background(
                            Capsule().frame(minWidth: 60, idealWidth: 80, maxWidth: 110, minHeight: 35)
                        )
                }
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button {
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
