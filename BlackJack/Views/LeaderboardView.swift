//
//  LeaderboardView.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 21/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    @Binding var highScore: [Double]
    @Binding var roundsWon : Int
    @Binding var roundsLost : Int
    var scoreDisplay: [Double]  {
        return highScore.reversed()
    }
    var body: some View {
            NavigationView {
                List {
                    // 2.
                    Section(header:
                        HStack {
                        Image(systemName: "list.number").foregroundColor(.blue)
                            .font(.system(size:30))
                            Text("Your Past Highscores")
                        })  {
                        ForEach(0 ..< scoreDisplay.count) {
                            Text("\(Int(scoreDisplay[$0]))$")
                        }
                               }

                    Section(header:
                        HStack {
                        Image(systemName: "star.circle.fill").foregroundColor(.yellow)
                            .font(.system(size:30))
                            Text("Your Achievements")
                        })  {
                           
                                Text("\(bronze.achievementText)\n\(bronze.requirementText)" )
                                    .opacity(roundsWon >= bronze.requirement ? 1 : 0.3)
                                    .foregroundColor(roundsWon >= bronze.requirement ? .blue : .gray)
                                Text("\(silver.achievementText)\n\(silver.requirementText)" ).opacity(roundsWon >= silver.requirement ? 1 : 0.3)
                                    .foregroundColor(roundsWon >= silver.requirement ? .blue : .gray)
                            
                                Text("\(gold.achievementText)\n\(gold.requirementText)" )
                                    .opacity(roundsWon >= gold.requirement ? 1 : 0.3)
                                    .foregroundColor(roundsWon >= gold.requirement ? .blue : .gray)
                            Text("\(rich.achievementText)\n\(rich.requirementText)" )
                                .opacity(Int(scoreDisplay.first ?? 0.00 ) >= rich.requirement ? 1 : 0.3)
                                .foregroundColor(Int(scoreDisplay.first ?? 0.00) >= rich.requirement ? .blue : .gray)
                            Text("\(richer.achievementText)\n\(richer.requirementText)" )
                                .opacity(Int(scoreDisplay.first ?? 0.00) >= richer.requirement ? 1 : 0.3)
                                .foregroundColor(Int(scoreDisplay.first ?? 0.00) >= richer.requirement ? .blue : .gray)
                            
                            }
                    Section(header:
                        HStack {
                        Image(systemName: "list.number").foregroundColor(.blue)
                            .font(.system(size:30))
                            Text("Statistics")
                        })  {
                            Text("😃Rounds Won: \(roundsWon)")
                            Text("🙃Rounds Lost: \(roundsLost)")
                               }
                
                } .navigationBarTitle("Statistics")
            }
               
        }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(highScore: .constant([]), roundsWon: .constant(0), roundsLost: .constant(0))
    }
}
