//
//  Achievements.swift
//  BlackJack
//
//  Created by Hieu Le Pham Ngoc on 23/08/2022.
//

import Foundation

struct achievement {
    let achievementText: String
    let requirementText: String
    let requirement: Int
}

let bronze = achievement.init(achievementText: "🥉Bronze", requirementText: "Win 5 rounds", requirement: 5)
let silver = achievement.init(achievementText: "🥈Silver", requirementText: "Win 10 rounds", requirement: 10)
let gold = achievement.init(achievementText: "🥇Gold", requirementText: "Win 20 rounds", requirement: 20)
let rich = achievement.init(achievementText: "💵Rich", requirementText: "Make 500$", requirement: 200)
let richer = achievement.init(achievementText: "💰Rolling in cash", requirementText: "Make 1000$", requirement: 1000)

