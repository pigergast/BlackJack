//
//  DifficultySettingView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 24/08/2022.
//

import SwiftUI

struct DifficultySettingView: View {
    @Binding var easyMode: Bool
    var body: some View {
        ZStack{
            Color("CasinoGreen")
            VStack(alignment: .center, spacing: 5){
                Form{
                    Section(header: Text("Easy")){
                        Button {
                            easyMode.toggle()
                            UserDefaults.standard.set(easyMode, forKey: "easyMode")
                        } label: {
                            Text(easyMode ? "Easy Mode: On" : "Easy Mode: Off")
                        }
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
