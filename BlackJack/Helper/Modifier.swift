//
//  Modifier.swift
//  BlackJack
//
//  Created by Oggy on 16/08/2022.
//

import SwiftUI

let decoder = JSONDecoder()

struct CardModifier: ViewModifier{
    func body(content: Content) -> some View {
           content
            .scaledToFit()	
            .frame(minWidth: 30, idealWidth: 50, maxWidth: 70)
            .shadow(color: .black, radius: 3)
       }
}

struct CapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
           content
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .foregroundColor(.green)
                )
       }
}
struct PlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("New Game").foregroundColor(.white)
        }
    }
}
struct ContinueModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Continue").foregroundColor(.white)
        }
    }
}
struct LeaderboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("Leaderboard").foregroundColor(.white)
        }
    }
}
struct TutorialModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 200, height: 75, alignment: .center).overlay {
            Text("How to play").foregroundColor(.white)
        }
    }
}

