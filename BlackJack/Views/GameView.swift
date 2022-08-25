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

//Main game view where player plays the game

struct GameView: View {
    //Game logic variables
    @Binding var easyMode: Bool
    @State var gameDeck = Deck()
    @State var dealerHand :[card] = []
    @Binding var roundsWon : Int
    @Binding var roundsLost : Int
    @State var playerHand: [card] = []
    @State var playerMoney : Double = 100
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
    
    //Function to set all game variables to the state it was inside the game save
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
    //Function to save current game
    func saveGame(){
        progressSave = continueGame(gameDeck: gameDeck, dealerHand: dealerHand, playerHand: playerHand, showIntro: showIntro, playerMoney: playerMoney, betAmount: betAmount, gameLoss: gameLoss, gameWin: gameWin, roundBust: roundBust, roundWin: roundWin, doubleDown: doubleDown, doubleAvailable: doubleAvailable, continueTrue: true)
        if let data = try? encoder.encode(continueGame(gameDeck: gameDeck, dealerHand: dealerHand, playerHand: playerHand, showIntro: showIntro, playerMoney: playerMoney, betAmount: betAmount, gameLoss: gameLoss, gameWin: gameWin, roundBust: roundBust, roundWin: roundWin, doubleDown: doubleDown, doubleAvailable: doubleAvailable, continueTrue: true)) {
            UserDefaults.standard.set(data, forKey: "gameSave")
        }
        
    }
    //When player lose a rouhd, deduct point
    func lose(){
        playSound(sound: "lose-Sound", type: "wav")
        roundsLost += 1
        //Keep track of how many rounds player lost for statistics
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
        if(playerMoney <= 0 || playerMoney < 10)
        {
            gameLoss = true
        }
        saveGame()
    }
    //Function to update a player's highscore list
    func checkUpdateHighscore(){
        if (playerMoney >  highscore.last ?? 100)
        {
            highscore.append(playerMoney)
            UserDefaults.standard.set(highscore, forKey: "highScoreList")
        }
    }
    //When a player win a round, add in their winning
    func handWin() {
        playSound(sound: "win-Sound", type: "wav")
        //Keep track of how many rounds they have won
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
    //Check if player has busted yet
    func checkPlayerStatus() {
        if (handValue(hand: playerHand) > 21){
            lose()
        }
        saveGame()
    }
    //Dealer's action after player's turn finished
    func dealerAction() {
        if(!roundBust && !roundWin)
        {
            //If easy mode, hit up to 14, else hit up to 17
            while(handValue(hand: dealerHand) < (easyMode ? 14 : 17)){
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
            //If easy mode, player win draw, else dealer win draw
            else if((handValue(hand: playerHand) == handValue(hand: dealerHand)) && easyMode) {
                handWin()
                return
            }
            else{
                lose()
                return
            }
        }
    }
    //Start a fresh game
    func newGame(){
        gameLoss = false
        playerMoney = 100
        newRound()
    }
    //Start a new round
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
    
    //Function that draws a card for player
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
                    //Button to head back to MenuView
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
                    //PlayerScore and highScore UI view from GameView Extension
                    playerScore
                    
                    Spacer()
                    
                    highScore
                }.frame(width: UIScreen.main.bounds.width, height: 120)
                Spacer()
                ZStack{
                    HStack {
                        //Cosmetic card deck
                        CardDeck()
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        HStack{
                            //Showing dealers hand
                            HStack{
                                //If round haven't end yet, show only one of the dealer's card face up, else show all the cards
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
                            //Show player's cards
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
                    //Button to let player bet 10
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
                    //Button that appears if round is over and lets player progress to new round
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
                    //Button to let player bet 20
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
                    //Button to let player hit
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
                    //Button to let player double down
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
                    //Button to end player's turn
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
            //Greeting screen that lets player start a round if its the start of a new game
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
            //If player is loading a save, show a continue button to let them get back to their save
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
            //If game lose, show button to let them start a new game
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

//Usage of extension to compact highscore and playerscore views
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
        GameView(easyMode: .constant(false), roundsWon: .constant(0), roundsLost: .constant(0), highscore: .constant([]), progressSave: .constant(continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false)))
    }
}
