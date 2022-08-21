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
    //@State var playerHand :[card] =
    //(UserDefaults.standard.object(forKey: "playerHand") as?  [card] ?? [])
    @State var playerHand: [card] = []
    @State var playerMoney : Double = 100
    @State private var highscore: [Double] = (UserDefaults.standard.object(forKey: "highScoreList") as? [Double] ?? [])
    @State var betAmount: Double = 10
    @State var showIntro = true
    @State var gameLoss = true
    @State var gameWin = false
    @State var roundBust = false
    @State var roundWin = false
    @State var doubleDown = false
    @State var doubleAvailable = true
    @Environment(\.presentationMode) var presentationMode: Binding
    func lose(){
        roundBust = true
        if (doubleDown == true){
            playerMoney -= (betAmount * 2)
        }
        else{
            playerMoney -= betAmount
        }
        if(playerMoney <= 0)
        {
            gameLoss = true
        }
    }
    
    func checkUpdateHighscore(){
        if (playerMoney >  highscore.last ?? 100)
        {
            highscore.append(playerMoney)
            UserDefaults.standard.set(highscore, forKey: "highScoreList")
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
        checkUpdateHighscore()
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
                withAnimation (.easeInOut(duration: 0.5)){
                    dealerHand.append(gameDeck.drawCard())
                }
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
    
    func newGame(){
        gameLoss = false
        playerMoney = 100
        newRound()
    }
    
    func newRound(){
        gameDeck.newDeck()
        dealerHand  = []
        playerHand = []
        roundWin = false
        roundBust = false
        doubleDown = false
        doubleAvailable = true
        for _ in 1...2{
            playerHand.append(gameDeck.drawCard())
            dealerHand.append(gameDeck.drawCard())
        }
    }
    
    func hit() {
        if(!roundBust && !roundWin && !doubleDown)
        {
            doubleAvailable = false
            withAnimation (.easeInOut(duration: 0.5)){
                playerHand.append(gameDeck.drawCard())
            }
            checkPlayerStatus()
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color("CasinoGreen"), Color.black]), center: .center, startRadius: 300, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/).ignoresSafeArea(.all)
            VStack{
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Image(systemName: "arrow.left.square.fill")
                            .foregroundColor(.black)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                .padding(.leading,10)
                    Spacer()
                }
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
                            HStack{
                                if(roundWin || roundBust){
                                    ForEach(dealerHand, id: \.self) { card in
                                        card.image.resizable().modifier(CardModifier())
                                    }
                                }
                                else {
                                    if(!dealerHand.isEmpty)
                                    {
                                        dealerHand[0].image.resizable().modifier(CardModifier())
                                        ForEach(0...dealerHand.count, id: \.self) { card in
                                            if(card > 1){
                                                Image("BACK").resizable().modifier(CardModifier())
                                            }
                                        }
                                    }
                                }
                            }
                        }.frame(height: 100)
                        Spacer()
                            .frame(height:130)
                        HStack{
                            HStack{
                                ForEach(playerHand, id: \.self) { card in
                                    card.image.resizable().modifier(CardModifier())
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
                                    .opacity((betAmount == 10) ? 1.0 : 0.3 )
                                    .animation(.easeInOut)
                            )
                    }
                    Spacer()
                    if(roundBust || roundWin) {
                        Button {
                            withAnimation(.easeInOut) {
                                newRound()
                            }
                            
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
                                    .opacity((betAmount == 20) ? 1.0 : 0.3 )
                                    .animation(.easeInOut)
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
                                    .foregroundColor((doubleDown || roundBust || roundWin) ? .red : .green)
                                    .animation(.easeInOut)
                                
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
                                    .foregroundColor(doubleAvailable ? .green : .red)
                                    .animation(.easeInOut)
                                
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
                                    .foregroundColor((roundWin || roundBust) ? .red : .green)
                                    .animation(.easeInOut)
                            )
                    }
                    Spacer()
                }
            }
            Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()
                .opacity(showIntro ? 1 : 0)
            if(showIntro){
                Button {
                    showIntro = false
                    newRound()
                    
                } label: {
                    Capsule().frame(width: 150, height: 100).foregroundColor(.yellow)
                        .overlay {
                            Text("Start")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.black)
                        }
                }
            }
            if(gameLoss){
                VStack{
                    RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 200)
                        .foregroundColor(Color("CrimsonRed")).overlay {
                            VStack{
                                Text(
                                    "You ran out of money!"
                                ).fontWeight(.bold).foregroundColor(.white)
                                Button {
                                    newGame()
                                } label: {
                                    Capsule().frame(width: 100, height: 50).foregroundColor(.green)
                                        .overlay {
                                            Text("Restart?")
                                                .font(.system(size: 22, weight: .heavy))
                                                .foregroundColor(.white)
                                        }
                                }
                                
                            }
                        }
                }
            }
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
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
            Text("\(Int(highscore.last ?? 100))")
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
