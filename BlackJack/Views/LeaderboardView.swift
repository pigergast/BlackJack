/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: Based on https://github.com/TomHuynhSG/RMIT-Casino usage's of userdefault
 */

import SwiftUI

//Leaderboard view to show player's leaderboard, statistics, and achievements

struct LeaderboardView: View {
    //Receive variables from menuView to display
    @Binding var highScore: [Double]
    @Binding var roundsWon : Int
    @Binding var roundsLost : Int
    //Reverse the highscore list so that the highest score is shown first
    var scoreDisplay: [Double]  {
        return highScore.reversed()
    }
    var body: some View {
        NavigationView {
            List {
                // High score list
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
                //Achievement List
                Section(header:
                            HStack {
                    Image(systemName: "star.circle.fill").foregroundColor(.yellow)
                        .font(.system(size:30))
                    Text("Your Achievements")
                })  {
                    //If player's statistic meets an achievement's requirement, un-opaque the achievement and make it blue to mark it as complete
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
                //Show how many rounds player have won and lost
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
