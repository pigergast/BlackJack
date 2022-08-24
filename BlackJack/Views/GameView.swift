//
//  GameView.swift
//  BlackJack
//
//  Created by Oggy on 16/08/2022.
//

import SwiftUI
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
struct GameView: View {
    @State var gameDeck = Deck()
    @State var dealerHand :[card] = []
    @Binding var roundsWon : Int
    @Binding var roundsLost : Int
    @State var playerHand: [card] = []
    @State var playerMoney : Double = 200
    @Binding var highscore: [Double]
    @Binding var progressSave: continueGame
    @State var betAmount: Double = 10
    @State var showIntro = true
    @State var gameLoss = false
    @State var gameWin = false
    @State var roundBust = false
    @State var roundWin = false
    @State var doubleDown = false
    @State var continuePressed = false
    @State var doubleAvailable = true
    @Environment(\.presentationMode) var presentationMode: Binding
    
    func resumeGame(save: continueGame){
        self.gameDeck = save.gameDeck
        self.dealerHand = save.dealerHand
        self.playerHand = save.playerHand
        self.playerMoney = save.playerMoney
        self.betAmount = save.betAmount
        self.showIntro = save.showIntro
        self.gameLoss = save.gameLoss
        self.gameWin = save.gameWin
        self.roundBust = save.roundBust
        self.roundWin = save.roundWin
        self.doubleDown = save.doubleDown
        self.doubleAvailable = save.doubleAvailable
    }
    
    func saveGame(){
        progressSave = continueGame(gameDeck: gameDeck, dealerHand: dealerHand, playerHand: playerHand, showIntro: showIntro, playerMoney: playerMoney, betAmount: betAmount, gameLoss: gameLoss, gameWin: gameWin, roundBust: roundBust, roundWin: roundWin, doubleDown: doubleDown, doubleAvailable: doubleAvailable, continueTrue: true)
        let encoder = JSONEncoder()
           if let data = try? encoder.encode(continueGame(gameDeck: gameDeck, dealerHand: dealerHand, playerHand: playerHand, showIntro: showIntro, playerMoney: playerMoney, betAmount: betAmount, gameLoss: gameLoss, gameWin: gameWin, roundBust: roundBust, roundWin: roundWin, doubleDown: doubleDown, doubleAvailable: doubleAvailable, continueTrue: true)) {
               UserDefaults.standard.set(data, forKey: "gameSave")
           }
     
    }
    func lose(){
        playSound(sound: "lose-Sound", type: "wav")
        roundsLost += 1
        UserDefaults.standard.set(roundsLost, forKey: "roundsLost")
        roundBust = true
        if (doubleDown == true){
            playerMoney -= (betAmount * 2)
        }
        else{
            playerMoney -= betAmount
        }
        if(playerMoney >= 10 && playerMoney < 20)
        {
            betAmount = 10
        }
        if(playerMoney <= 0 || playerMoney <= 10)
        {
            gameLoss = true
        }
        saveGame()
    }
    
    func checkUpdateHighscore(){
        if (playerMoney >  highscore.last ?? 100)
        {
            highscore.append(playerMoney)
            UserDefaults.standard.set(highscore, forKey: "highScoreList")
        }
    }
    
    func handWin() {
        playSound(sound: "win-Sound", type: "wav")
        
        roundsWon += 1
        UserDefaults.standard.set(roundsWon, forKey: "roundsWon")
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
        saveGame()
    }
    
    func checkPlayerStatus() {
        if (handValue(hand: playerHand) > 21){
            lose()
        }
        saveGame()
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
        playSound(sound: "shuffling-cards", type: "mp3")
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
        saveGame()
    }
    
    func hit() {
        
        if(!roundBust && !roundWin && !doubleDown)
        {
            playSound(sound: "card-hit", type: "mp3")
            doubleAvailable = false
            withAnimation (.easeInOut(duration: 0.5)){
                playerHand.append(gameDeck.drawCard())
            }
            checkPlayerStatus()
            saveGame()
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color("CasinoGreen"), Color("LightGreen")]), center: .center, startRadius: 300, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/).ignoresSafeArea(.all)
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
                        playSound(sound: "chips", type: "mp3")
                    } label: {
                        Text("Bet 10")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(width: 80, height: 30)
                                    .opacity((betAmount == 10 || playerMoney < 20) ? 1.0 : 0.3 )
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
                        if(playerMoney >= 20){
                            betAmount = 20
                            playSound(sound: "chips", type: "mp3")
                        }
                        else{
                            betAmount = 10
                        }
                    }
                label: {
                    Text("Bet 20")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.black)
                        .background(
                            Capsule().frame(width: 80, height: 30)
                                .opacity((betAmount == 20 && playerMoney >= 20) ? 1.0 : 0.3 )
                                .animation(.easeInOut)
                        )
                }
                }.padding(.horizontal, 10)
                Spacer(minLength: 30)
                HStack{
                    Spacer()
                    Button {
                        hit()
                    } label: {
                        Text("Hit")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(minWidth: 50, idealWidth: 70, maxWidth: 100, minHeight: 50)
                                    .foregroundColor((doubleDown || roundBust || roundWin) ? .red : .green)
                                    .animation(.easeInOut)
                                
                            )
                    }
                    Spacer()
                    Button {
                        if(doubleAvailable == true){
                            hit()
                            doubleDown = true
                            doubleAvailable = false
                        }
                    } label: {
                        Text("Double")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.black)
                            .background(
                                Capsule().frame(minWidth: 100, minHeight: 50)
                                    .foregroundColor((doubleAvailable && !roundWin && !roundBust) ? .green : .red)
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
                                Capsule().frame(minWidth: 100, minHeight: 50)
                                    .foregroundColor((roundWin || roundBust) ? .red : .green)
                                    .animation(.easeInOut)
                            )
                    }
                    Spacer()
                }
            }
            Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()
                .opacity((showIntro || gameLoss) ? 1 : 0)
            if(showIntro){
                Button {
                    continuePressed = true
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
            if(progressSave.continueTrue && !continuePressed){
                Button {
                    continuePressed = true
                    resumeGame(save: progressSave)
                    
                } label: {
                    Capsule().frame(width: 150, height: 100).foregroundColor(.yellow)
                        .overlay {
                            Text("Continue")
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
                }.onAppear{ playSound3(sound: "game-Over", type: "wav")}
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
        }        .modifier(CapsuleModifier())
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
        GameView(roundsWon: .constant(0), roundsLost: .constant(0), highscore: .constant([]), progressSave: .constant(continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false)))
    }
}
