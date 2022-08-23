//
//  MenuView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 05/08/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color("CasinoGreen"), Color("LightGreen")]), center: .center, startRadius: 300, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/).ignoresSafeArea(.all)
                VStack {
                    NavigationLink(destination: GameView().onAppear{playSound2(sound: "background-jazz", type: "mp3")}) { Capsule().foregroundColor(Color("CrimsonRed")).modifier(PlayModifier())}
                    NavigationLink(destination: LeaderboardView().onAppear{
                        playSound2(sound: "leaderboard", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(LeaderboardModifier())}
                    NavigationLink(destination: TutorialView().onAppear{
                        playSound2(sound: "tutorial", type: "mp3")
                    }) { Capsule()
                        .foregroundColor(Color("CrimsonRed")).modifier(TutorialModifier())}
                }
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
