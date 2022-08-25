/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Le Pham Ngoc Hieu
 ID: 3877375
 Created  date: 05/08/2022
 Last modified: 25/08/2022
 Acknowledgement: none
 */

import Foundation

//Achievement struct for use in leaderboard
struct achievement {
    let achievementText: String
    let requirementText: String
    let requirement: Int
}

//Declaring existing achievements
let bronze = achievement.init(achievementText: "🥉Bronze", requirementText: "Win 5 rounds", requirement: 5)
let silver = achievement.init(achievementText: "🥈Silver", requirementText: "Win 10 rounds", requirement: 10)
let gold = achievement.init(achievementText: "🥇Gold", requirementText: "Win 20 rounds", requirement: 20)
let rich = achievement.init(achievementText: "💵Rich", requirementText: "Make 500$", requirement: 500)
let richer = achievement.init(achievementText: "💰Rolling in cash", requirementText: "Make 1000$", requirement: 1000)

