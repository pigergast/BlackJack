//
//  LeaderboardView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 21/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    var highscore: [Double] = (UserDefaults.standard.object(forKey: "highScoreList") as? [Double] ?? [])
    var scoreDisplay: [Double]
    let asianCars = ["Honda","Nissan","Suzuki"]
    init() {
       scoreDisplay = highscore.reversed()
    }
        
    var body: some View {
            NavigationView {
                List {
                    // 2.
                    Section(header:
                        Text("Your Highscores")) {
                            ForEach(0 ..< scoreDisplay.count) {
                                Text("\(Int(scoreDisplay[$0]))")
                            }
                        }
                    // 3.
                    Section(header:
                        HStack {
                            Image(systemName: "car")
                            Text("Asian Cars")
                        }
                    // 4.
                    , footer: Text("This is a example list of a few car brands").font(.footnote))  {
                                   ForEach(0 ..< asianCars.count) {
                                       Text(self.asianCars[$0])
                                   }
                               }
                
                } .navigationBarTitle("Leaderboard")
            }
               
        }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
