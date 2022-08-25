/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: Based on sample code from https://www.hackingwithswift.com/books/ios-swiftui/creating-a-form
 */

import SwiftUI

//Tutorial view to instruct player on how to play the game

struct TutorialView: View {
    var body: some View {
        ZStack{
            Color("CasinoGreen")
            VStack(alignment: .center, spacing: 5){
                Form{
                    Section(header: Text("Blackjack Basics")){
                        Text("Try to get your hand as close to 21 as possible to beat the dealer's hand without busting, which is going over 21")
                        Text("Face cards are 10, Ace can be worth either 1 or 11")
                        Text("If your hands is 21, you have a Blackjack and get your bet multiplied by 1.5")
                    }
                    
                    Section(header: Text("Player Actions"), footer: Text("Hint: Actions UI are green when they can be picked and red when locked out")){
                        Text("Hitting will draw another card")
                        Text("Double down will let you double your bet by drawing extra card, however you are locked from any other action")
                        Text("Stand will end your turn")
                    }
                }
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
