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

//Difficulty setting view to let player select their desired difficulty

struct DifficultySettingView: View {
    @Binding var easyMode: Bool
    var body: some View {
        ZStack{
            Color("CasinoGreen")
            VStack(alignment: .center, spacing: 5){
                //Menu to toggle Easy/Real Life mode and remember that decision in userDefault so that next time app is turned on again, the desired mode will be turn on
                Form{
                    Section(header: Text("Easy")){
                        Button {
                            easyMode.toggle()
                            UserDefaults.standard.set(easyMode, forKey: "easyMode")
                        } label: {
                            Text(easyMode ? "Easy Mode: On" : "Easy Mode: Off")
                        }
                        //Explain what easy mode is
                        Text("Dealer always draw when their hand is less than 14")
                        Text("Player win on draws")
                    }
                    
                    Section(header: Text("Real Life")){
                        Button {
                            easyMode.toggle()
                            UserDefaults.standard.set(easyMode, forKey: "easyMode")
                        } label: {
                            Text(!easyMode ? "Real Life Mode: On" : "Real Life Mode: Off")
                        }
                        //Explain what real life mode is
                        Text("Dealer always draw when their hand is less than 17")
                        Text("Dealer win on draws")
                    }
                }
            }
        }
    }
}

struct DifficultySettingView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultySettingView(easyMode: .constant(false))
    }
}
