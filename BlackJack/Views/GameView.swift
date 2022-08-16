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
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    Capsule()
                        .foregroundColor(.green)
                        .opacity(0.4)
            )
                Spacer()
                HStack{
                    Text("High\nScore")
                        .font(.system(size: 22, weight: .medium))
                    .multilineTextAlignment(.leading)
                    Text("100")
                        .font(.system(size: 22, weight: .medium))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    Capsule()
                        .foregroundColor(.yellow)
                        .opacity(0.4)
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
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
